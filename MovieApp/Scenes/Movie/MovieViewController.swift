//
//  MovieViewController.swift
//  MovieApp
//
//  Created by Berk Pehlivanoğlu on 11.09.2022.
//

import UIKit
import Moya

final class MovieViewController: UIViewController, Layouting, AlertShowing {

    typealias ViewType = MovieView

    var movies: [Movie] = []

    override func loadView() {
        view = ViewType.create()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - Setup Helper
extension MovieViewController {

    func setupView() {
        title = Strings.movieTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = layoutableView.searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        layoutableView.tableView.dataSource = self
        layoutableView.tableView.delegate = self
        
        layoutableView.searchController.searchBar.delegate = self
    }

}
// MARK: - UISearchControllerDelegate, UISearchBarDelegate
extension MovieViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let title = searchBar.text else { return }
        fetchMovie(title: title)
    }
}

// MARK: - Networking
extension MovieViewController {

    func fetchMovie(title: String) {

        layoutableView.setLoading(true)
        movies.removeAll()
        layoutableView.tableView.reloadData()
        
        API.movieProvider.request(.search(title: title)) { [weak self] result in

            guard let self = self else { return }

            self.layoutableView.setLoading(false)

            switch result {
            case .failure(let error):
                self.showAlert(title: Strings.appTitle, message: error.localizedDescription)

            case .success(let response):

                if let errorData = try? response.map(ErrorResponse.self) {
                    self.showAlert(title: Strings.appTitle, message: errorData.error)
                    return
                }
                guard let data = try? response.map(SearchResponse.self) else {
                    return
                }
                guard data.response != "False" else {
                    self.showAlert(title: Strings.appTitle, message: "Movie not found")
                    return
                }
                guard data.search.count > 0 else {
                    self.showAlert(title: Strings.appTitle, message: "Movie not found")
                    return
                }

                self.movies = data.search
                self.layoutableView.endEditing(true)
                self.layoutableView.tableView.reloadData()
            }
        }

    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 136
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        cell.configure(movie: movies[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard movies.count > 0 else { return }
        let movieDetailViewController = MovieDetailViewController(movie: movies[indexPath.row])
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
