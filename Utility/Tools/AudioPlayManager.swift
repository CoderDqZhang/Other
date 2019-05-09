
//
//  AudioPlayManager.swift
//  CatchMe
//
//  Created by Zhang on 09/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPlayManager: NSObject {

    var audioPlayer:AVAudioPlayer!
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(self.volumeClicked), name: NSNotification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification"), object: nil)
        UIApplication.shared.beginReceivingRemoteControlEvents()
    }
    
    static let shareInstance = AudioPlayManager()
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification"), object: nil)
    }
    
    func playBgMusic(name:String){
//        let musicPath = Bundle.main.path(forResource: name, ofType: ".mp3")
//        //指定音乐路径
//        let url = URL.init(fileURLWithPath: musicPath!)
//        if audioPlayer != nil {
//            audioPlayer.stop()
//            audioPlayer = nil
//        }
//        do {
//            try audioPlayer = AVAudioPlayer.init(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
//            audioPlayer.numberOfLoops = -1
//            //设置音乐播放次数，-1为循环播放
//            audioPlayer.volume = 0.8
//            audioPlayer.delegate = self
//            //设置音乐音量，可用范围为0~1
//            audioPlayer.prepareToPlay()
//            audioPlayer.play()
//        } catch  {
//            print("error")
//        }
        
    }
    
    func isPlaying() -> Bool{
//        if self.audioPlayer != nil {
//            return self.audioPlayer.isPlaying
//        }
        return false
    }
    
    func pause(){
//        if self.audioPlayer != nil {
//            self.audioPlayer.pause()
//        }
    }
    
    func stop(){
//        if self.audioPlayer != nil {
//            self.audioPlayer.stop()
//        }
    }
    //监听音量键 调节
    @objc func volumeClicked(notification:Notification){
        
    }
}

extension AudioPlayManager : AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
    }
}

