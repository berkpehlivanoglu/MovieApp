//
//  SplashView.swift
//  MovieApp
//
//  Created by Berk Pehlivanoğlu on 11.09.2022.
//

import UIKit

final class SplashView: UIView & Layoutable {
    
    // MARK: - Properties
    lazy var appImageView: UIImageView = {
       let view = UIImageView(frame: CGRect(x: 0, y: 0, width: preferredSpacing * 8, height: preferredSpacing * 8))
        view.image = UIImage(named: "appIcon")
        return view
    }()
    
    lazy var appTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.text = "MovieApp"
        label.textColor = .white
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [appImageView, appTitleLabel])
        view.axis = .vertical
        view.alignment = .center
        view.spacing = preferredSpacing * 0.8
        return view
    }()
    
    lazy var splashTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    // MARK: - Setups
    func setupViews() {
        addSubview(stackView)
        addSubview(splashTitle)
    }
    
    func setupLayout() {
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(preferredSpacing * 11)
            make.centerX.equalToSuperview()
        }
        splashTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom).offset(preferredSpacing * 4)
        }
    }
}
