//
//  SoundCell.swift
//  Six
//
//  Created by Jax on 2021/1/21.
//  Copyright © 2021 luxshare-ict. All rights reserved.
//
import Cocoa
import AVFoundation
//import FRadioPlayer

class SoundCell: NSTableCellView {

    @IBOutlet weak var progressView: NSProgressIndicator!
    @IBOutlet weak var startButton: NSButton!
    @IBOutlet weak var percentLabel: NSTextField!
    
    var url:String?
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    @IBAction func playRadio(_ sender: NSButton) {
        //---
        
        
    }
}

//extension SoundCell: FRadioPlayerDelegate {
//
//    func radioPlayer(_ player: FRadioPlayer, playerStateDidChange state: FRadioPlayerState) {
////        statusLabel.stringValue = state.description
//    }
//
//    func radioPlayer(_ player: FRadioPlayer, playbackStateDidChange state: FRadioPlaybackState) {
////        playButton.isSelected = player.isPlaying
//    }
//
//    func radioPlayer(_ player: FRadioPlayer, metadataDidChange artistName: String?, trackName: String?) {
////        track = Track(artist: artistName, name: trackName)
//    }
//
//    func radioPlayer(_ player: FRadioPlayer, metadataDidChange rawValue: String?) {
//        print("Raw Meta:", rawValue ?? "none")
//    }
//
//    func radioPlayer(_ player: FRadioPlayer, itemDidChange url: URL?) {
////        track = nil
//    }
//
//    func radioPlayer(_ player: FRadioPlayer, artworkDidChange artworkURL: URL?) {
//
//        // Please note that the following example is for demonstration purposes only, consider using asynchronous network calls to set the image from a URL.
//
//    }
//}
