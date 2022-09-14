//
//  RemoteConfigs.swift
//  MovieApp
//
//  Created by Berk Pehlivanoğlu on 11.09.2022.
//

import Foundation
import FirebaseRemoteConfig

struct RemoteConfigs {
    static let shared = RemoteConfigs()
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    // MARK: - FetchingValues
    func fetchValues(with label: UILabel) {
        let defaults: [String: NSObject]  = ["splash_title": "LOODOS" as NSObject]
        
        remoteConfig.setDefaults(defaults)
        
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        self.remoteConfig.fetch(withExpirationDuration: 100) { status, error in
            if status == .success, error == nil {
                self.remoteConfig.activate { changed, error in
                    guard error == nil else {
                        return
                    }
                    if let value = self.remoteConfig.configValue(forKey: "splash_title").stringValue {
                        updateUI(with: label, with: value)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        let scene = UIApplication.shared.connectedScenes.first
                        if let sceneDelegate: SceneDelegate = (scene?.delegate as? SceneDelegate) {
                            let homeViewController = UINavigationController(rootViewController: MovieViewController())
                            sceneDelegate.window?.rootViewController = homeViewController
                        }
                    }
                    
                }
                
            } else {
                print("Something wrong")
            }
        }
    }
    
    // MARK: - UpdatingSplashTitle
    func updateUI(with label: UILabel, with labelText: String) {
        DispatchQueue.main.async {
            label.text = labelText
        }
    }
}
