//
//  SplashPresenter.swift
//  SkyScapes
//
//  Created by Никита Абаев on 21.07.2024.
//

import UIKit


protocol SplashPresenterDescription {
    func present()
    func dismiss(complition: (() -> Void)?)
}


final class SplashPresenter: SplashPresenterDescription {
   
    private lazy var textImage: UIImage? = {
        let textsCount = 7
        let randomNumber = Int.random(in: 1...textsCount)
        let imageName = "i-splash-text-\(randomNumber)"
        return UIImage(named: imageName)
    }()
   
    private lazy var foregroundSplashWindow: UIWindow = {
       let splashWindow = UIWindow()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let splashViewController = storyboard.instantiateViewController(identifier: "SplashViewController") as? SplashViewController
        splashViewController?.textImage = textImage
        
        splashWindow.windowLevel = .normal + 1
        splashWindow.rootViewController = splashViewController
        
        return splashWindow
    }()
    
    func present() {
        foregroundSplashWindow.isHidden = false
        
        let splashViewController = foregroundSplashWindow.rootViewController as? SplashViewController
        splashViewController?.textImageView.transform = CGAffineTransform(translationX: 0, y: 20)
        UIView.animate(withDuration: 0.3) {
            splashViewController?.textImageView.transform = .identity
            splashViewController?.logoImageView.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        }
        splashViewController?.textImageView.alpha = 0
        UIView.animate(withDuration: 0.15) {
            splashViewController?.textImageView.alpha = 1
        }
    }
    
    func dismiss(complition: (() -> Void)?) {
        UIView.animate(withDuration: 0.3) {
            self.foregroundSplashWindow.alpha = 0
        } completion: { (_) in
            complition?()
        }

    }
}
