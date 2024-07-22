//
//  VideoPlayerManager.swift
//  SkyScapes
//
//  Created by Никита Абаев on 22.07.2024.
//


import UIKit
import AVFoundation

class VideoPlayerManager {
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private var videoView: UIView
    
    init(videoView: UIView) {
        self.videoView = videoView
    }
    
    func playVideo(named name: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp4") else { return }
        let url = URL(fileURLWithPath: path)
        let newPlayer = AVPlayer(url: url)
        let newPlayerLayer = AVPlayerLayer(player: newPlayer)
        newPlayerLayer.frame = videoView.bounds
        newPlayerLayer.videoGravity = .resizeAspectFill
        
        
        if let currentLayer = playerLayer {
            let transitionView = UIView(frame: videoView.bounds)
            transitionView.backgroundColor = .black
            videoView.addSubview(transitionView)
            
            UIView.animate(withDuration: 0.5, animations: {
                transitionView.alpha = 1.0
            }) { _ in
                self.videoView.layer.replaceSublayer(currentLayer, with: newPlayerLayer)
                self.videoView.bringSubviewToFront(transitionView)
                
                UIView.animate(withDuration: 0.5, animations: {
                    transitionView.alpha = 0.0
                }) { _ in
                    transitionView.removeFromSuperview()
                }
            }
        } else {
            videoView.layer.addSublayer(newPlayerLayer)
        }
        
        playerLayer = newPlayerLayer
        player = newPlayer
        player?.play()
        player?.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(videoDidPlayToEnd),
            name: .AVPlayerItemDidPlayToEndTime,
            object: player?.currentItem
        )
    }
    
    @objc private func videoDidPlayToEnd(notification: Notification) {
        let player: AVPlayerItem = notification.object as! AVPlayerItem
        player.seek(to: .zero, completionHandler: nil)
    }
}



