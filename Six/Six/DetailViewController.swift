//
//  DetailViewController.swift
//  Six
//
//  Created by Jax on 2021/1/5.
//  Copyright © 2021 luxshare-ict. All rights reserved.
//

import Cocoa
import Kingfisher
import AVKit

class DetailViewController: NSViewController {

    
    var item:DetailList?
    
    @IBOutlet weak var widthConstant: NSLayoutConstraint!
    @IBOutlet var textContent: NSTextView!
    @IBOutlet weak var image: NSImageView!
    var change = false
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.white.cgColor
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "DeialItemChange"), object: nil, queue: nil) { (notice) in
            print(notice)
            let item:DetailList = notice.object as! DetailList
            DispatchQueue.main.async {
                self.refreshUIByModel(theModel: item)
            }
        }
        
        let app:AppDelegate = NSApplication.shared.delegate as! AppDelegate
        app.detailVC = self
        
    }
    
    func refreshUIByModel(theModel list:DetailList)  {
        self.image.kf.indicatorType = .activity
        self.image.kf.setImage(with: URL.init(string: list.data.image._url!)!)
        

        let attributeString = NSAttributedString.init(string: list.data.text ?? "error", attributes: [NSAttributedString.Key.font:NSFont.systemFont(ofSize: 15)])
        self.textContent.textStorage?.setAttributedString(attributeString)
        self.textContent.setAlignment(.center, range: NSRange.init(location: 0, length: self.textContent.attributedString().length))
    }
    
    @IBAction func change(_ sender: Any) {
        change = !change
        
        if change {
            self.widthConstant.constant = 1000
        }else{
            self.widthConstant.constant = 450
        }
        
        
    }
    
    
}
