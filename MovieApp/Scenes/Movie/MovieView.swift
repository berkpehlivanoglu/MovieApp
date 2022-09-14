//
//  MovieView.swift
//  MovieApp
//
//  Created by Berk Pehlivanoğlu on 11.09.2022.
//

import UIKit

final class MovieView: UIView, Layoutable, Loadingable {
    
    // MARK: - Properties
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "homeCell")
        tableView.keyboardDismissMode = .interactive
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .singleLine
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        return tableView
    }()
    
    lazy var searchController: UISearchController = {
        var searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = .prominent
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        return searchController
    }()
    
    // MARK: - Setups
    func setupViews() {
        backgroundColor = .white
        addSubview(tableView)
    }
    
    func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(preferredSpacing)
            make.bottom.equalToSuperview()
        }
    }
}
