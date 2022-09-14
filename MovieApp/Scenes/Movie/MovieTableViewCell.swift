//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Berk Pehlivanoğlu on 13.09.2022.
//

import UIKit
import Kingfisher

final class MovieTableViewCell: UITableViewCell, Layoutable {
    
    // MARK: - Initilization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        return label
    }()

    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()

    func setupViews() {
        addSubview(movieImageView)
        addSubview(titleLabel)

    }

    func setupLayout() {
        movieImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(preferredSpacing * 0.8)
            make.leading.equalToSuperview()
            make.height.width.equalTo(104)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(movieImageView.snp.trailing).offset(preferredSpacing * 0.4)
            make.width.equalTo(preferredSpacing * 10.2)
            make.top.equalToSuperview().inset(preferredSpacing * 1.2)
        }
        
    }

}

// MARK: - Configure
extension MovieTableViewCell {

    func configure(movie: Movie) {
//        let arrow = #imageLiteral(resourceName: "arrow")
        titleLabel.text = "\(movie.title) (\(movie.year))"
        movieImageView.kf.setImage(with: URL(string: movie.poster), placeholder: #imageLiteral(resourceName: "appIcon"))

    }

}
