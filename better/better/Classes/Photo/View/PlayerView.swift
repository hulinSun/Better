//
//  PlayerView.swift
//  better
//
//  Created by Hony on 2016/12/7.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerView: UIView {
    
    static let url = "http://gslb.miaopai.com/stream/kPzSuadRd2ipEo82jk9~sA__.mp4"
    
    fileprivate lazy var playItem: AVPlayerItem = {
        let i = AVPlayerItem.init(url: URL(string: url)!)
        return i
    }()
    
    fileprivate lazy var play: AVPlayer = {
        let i = AVPlayer.init(playerItem: self.playItem)
        return i
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addObserve()
        
        
    }
    
    
    fileprivate lazy var playLayer: AVPlayerLayer = {
        let i = AVPlayerLayer.init(player: self.play)
        return i
    }()
    

    private func setupUI(){
        playLayer.position = .zero
        playLayer.frame = CGRect(x: 0, y: 0, width: UIConst.screenWidth, height: UIConst.screenWidth * 0.75)
        playLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        layer.insertSublayer(playLayer, at: 0)
        play.play()
        
        print(play.rate) // 判断是否暂停
        
        /// 其实是添加定时器，没个一秒做操作
        play.addPeriodicTimeObserver(forInterval: CMTimeMake(1, 1), queue: DispatchQueue.main, using: {
            time in
            // 当前播放时间
            let current = CMTimeGetSeconds(self.playItem.currentTime())
            
            // 总时长
            let all = CMTimeGetSeconds(self.playItem.duration)
            // 播放进度
            let pro = current / all
            print("当前播放时间 = \(current) , progress = \(pro)")
        })
    }
    
    
    private func addObserve(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.moviePlayDidEnd(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playItem)
        
        playItem.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.new, context: nil)
        
        playItem.addObserver(self, forKeyPath: "loadedTimeRanges", options: NSKeyValueObservingOptions.new, context: nil)
        
        // 缓冲区空了，需要等待数据
        playItem.addObserver(self, forKeyPath: "playbackBufferEmpty", options: NSKeyValueObservingOptions.new, context: nil)
        // 缓冲区有足够数据可以播放了
        playItem.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    /// 播放完毕
    func moviePlayDidEnd(_ note: Notification)  {
        print("播放完毕")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
            if self.play.currentItem?.status == AVPlayerItemStatus.readyToPlay {
                let draggedTime = CMTimeMake(Int64(1), 1)
                self.play.seek(to: draggedTime, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero, completionHandler: { (finished) in
                    
                    // 在这里还可以做缩略图的生成
//                    AVAssetImageGenerator
                    
                    // 调到某个时间，在开始播放
                    self.play.play()
                })
            }
        })
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard  let key = keyPath , let changeValue = change else { return }
        
        let new = changeValue[.newKey]
        switch key {
            
        case "status":
            print("status \(new!)")
        case "loadedTimeRanges":
            // 计算缓冲进度
            if let timeInterVarl    = self.availableDuration() {
                
                // 总时长
                let duration        = playItem.duration
                let totalDuration   = CMTimeGetSeconds(duration)
                
                print("time = \(timeInterVarl) , total = \(totalDuration)")
            }
            
        case "playbackBufferEmpty":
            print("playbackBufferEmpty \(new!)")
            
        case "playbackLikelyToKeepUp":
            print("playbackLikelyToKeepUp \(new!)")
            
        default:
            print("--")
        }
    }
    
    fileprivate func availableDuration() -> TimeInterval? {
        
        if let loadedTimeRanges = play.currentItem?.loadedTimeRanges,
            let first = loadedTimeRanges.first {
            let timeRange = first.timeRangeValue
            let startSeconds = CMTimeGetSeconds(timeRange.start)
            let durationSecound = CMTimeGetSeconds(timeRange.duration)
            let result = startSeconds + durationSecound
            return result
        }
        return nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
