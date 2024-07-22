//
//  ViewController.swift
//  SkyScapes
//
//  Created by Никита Абаев on 21.07.2024.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    //MARK: - IBOutlets CollectionView
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var videoView: UIView!
    
//   private let titles = ["Clear", "Thunderstorm", "Wind", "Fog", "Rainbow", "Snow"]
    
    private let titles = [
            NSLocalizedString("button_title_clear", comment: "Ясно"),
            NSLocalizedString("button_title_thunderstorm", comment: "Гроза"),
            NSLocalizedString("button_title_wind", comment: "Ветер"),
            NSLocalizedString("button_title_fog", comment: "Туман"),
            NSLocalizedString("button_title_rainbow", comment: "Радуга"),
            NSLocalizedString("button_title_snow", comment: "Снег")
        ]
    
        private let images = [
            UIImage(systemName: "sun.max.fill"),
            UIImage(systemName: "cloud.rain.fill"),
            UIImage(systemName: "wind"),
            UIImage(systemName: "cloud.fog.fill"),
            UIImage(systemName: "rainbow"),
            UIImage(systemName: "cloud.snow.fill")
        ]
        private let videoFiles = ["clear", "thunderstorm", "wind", "fog", "rainbow", "snow"]
        
        private var videoPlayerManager: VideoPlayerManager!
        private var selectedIndex: Int?

        override func viewDidLoad() {
            super.viewDidLoad()
            collectionView.dataSource = self
            collectionView.delegate = self
            let bottomCellNib = UINib(nibName: "ButtonCell", bundle: nil)
            collectionView.register(bottomCellNib, forCellWithReuseIdentifier: "ButtonCell")
            
            videoPlayerManager = VideoPlayerManager(videoView: videoView)
            setupView()
        }
        
        private func setupView() {
            let randomIndex = Int.random(in: 0..<videoFiles.count)
            videoPlayerManager.playVideo(named: videoFiles[randomIndex]) // Воспроизведение случайного видео при запуске
            selectedIndex = randomIndex
            collectionView.reloadData()
        }
        
    @objc func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return titles.count
        }
        
    @objc internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCell", for: indexPath) as? ButtonCell else {
                return UICollectionViewCell()
            }
        let isSelected = indexPath.item == selectedIndex
        cell.configure(image: images[indexPath.item], title: titles[indexPath.item], isSelected: isSelected)
            cell.button.tag = indexPath.item
            cell.button.addTarget(self, action: #selector(handleButtonTap(_:)), for: .touchUpInside)
            return cell
        }
        
        @objc private func handleButtonTap(_ sender: UIButton) {
            let videoName = videoFiles[sender.tag]
            videoPlayerManager.playVideo(named: videoName)
            selectedIndex = sender.tag
            collectionView.reloadData()
        }
}


