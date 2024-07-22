//
//  SplashViewController.swift
//  SkyScapes
//
//  Created by Никита Абаев on 21.07.2024.
//

import UIKit


final class SplashViewController:  UIViewController {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var textImageView: UIImageView!
    
    var textImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textImageView.image = textImage
    }
}
