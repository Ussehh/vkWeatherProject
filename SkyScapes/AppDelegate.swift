//
//  AppDelegate.swift
//  SkyScapes
//
//  Created by Никита Абаев on 21.07.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
   
    var window: UIWindow?
    private var splashPresenter: SplashPresenterDescription? = SplashPresenter()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        splashPresenter?.present()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.splashPresenter?.dismiss(complition: { [weak self] in
                self?.splashPresenter = nil
            })
        }
        
        
        return true
    }
}


