//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Berk Pehlivanoğlu on 13.09.2022.
//

import UIKit
import FirebaseAnalytics

final class MovieDetailViewController: UIViewController, Layouting, AlertShowing {
    // MARK: - Initialization
    typealias ViewType = MovieDetailView
    
    override func loadView() {
        view = ViewType.create()
    }
    
    private var movie: Movie?
    private var movieDetail: MovieDataResponse?
    
    convenience init(movie: Movie) {
        self.init()
        self.movie = movie
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        movieDetailEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovieDetail(title: movie?.title ?? "")
    }
    
}
// MARK: - SetupHelper
extension MovieDetailViewController {
    func setupView() {
        title = movie?.title
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .black
    }
}
// MARK: - Networking
extension MovieDetailViewController {
    func fetchMovieDetail(title: String) {
        layoutableView.setLoading(true)
        
        API.movieProvider.request(.showDetail(title: title)) { [weak self] result in
            
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
                guard let data = try? response.map(MovieDataResponse.self) else {
                    return
                }
                guard data.response != "False" else {
                    self.showAlert(title: Strings.appTitle, message: "Movie not found")
                    return
                }
                
                self.movieDetail = data
                guard let movieDetail = self.movieDetail else { return }
                self.layoutableView.configure(movie: movieDetail)
                self.layoutableView.endEditing(true)
            }
        }
    }
}

// MARK: - SettingFirebaseAnalytics
extension MovieDetailViewController {
    func movieDetailEvent() {
        guard let movie = self.movie else {
            return
        }

        Analytics.logEvent("movie_detail", parameters: [
            "movie_imdbID": movie.imdbID,
            "movie_title": movie.title,
            "movie_type": movie.type,
            "movie_year": movie.year
            ])
    }
}
