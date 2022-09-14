//
//  SplashViewController.swift
//  MovieApp
//
//  Created by Berk Pehlivanoğlu on 9.09.2022.
//

import UIKit
import Network

final class SplashViewController: UIViewController & Layouting, AlertShowing {
    // MARK: - Initialization
    typealias ViewType = SplashView
    
    override func loadView() {
        view = ViewType.create()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setSplashAnimation()
    }
}

// MARK: - MonitoringNetWork
extension SplashViewController {
    func monitorNetwork() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    RemoteConfigs.shared.fetchValues(with: self.layoutableView.splashTitle)
                    
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert(title: Strings.appTitle, message: Strings.networkMessage)
                }
            }
        }
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
}

// MARK: - SettingSplashAnimation
extension SplashViewController {
    func setSplashAnimation() {
        UIView.animate(withDuration: 1, animations: {
            self.layoutableView.stackView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            
        }) { _ in
            UIView.animate(withDuration: 1, animations: {
                self.layoutableView.stackView.transform = CGAffineTransform.identity
            })
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.monitorNetwork()
        }
    }
}
