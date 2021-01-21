//
//  ContentView.swift
//  Six
//
//  Created by Jax on 2021/1/7.
//  Copyright © 2021 luxshare-ict. All rights reserved.
//

import Cocoa

class ContentView: NSView {
    
    @IBOutlet var custmerView: NSView!
    var course:Course?
    var currentIndex:Int = 0
    var isChinese:Bool = true
    var hideContent:Bool = false
    @IBOutlet weak var titleLabel: NSTextField!
    
    @IBOutlet weak var tips: NSTextField!
    
    @IBOutlet var contentTextView: NSTextView!
    
    @IBOutlet weak var changeButton: NSButton!
    @IBOutlet weak var homeButton: NSButton!
    @IBOutlet weak var lastButton: NSButton!
    @IBOutlet weak var nextButton: NSButton!
    @IBOutlet weak var hideButton: NSButton!
    var callBack:((Int)->())?
    
    
    
    @IBOutlet weak var imageView: NSImageView!
    
    //init from xib
      required init?(coder: NSCoder) {
          super.init(coder: coder)
          
          if Bundle.main.loadNibNamed("ContentView", owner: self, topLevelObjects: nil) {
                 addSubview(custmerView)
             }
          hiddenButton(hide: false)
          
      }
    
    func hiddenButton(hide:Bool) {
        self.changeButton.isHidden = hide
        self.homeButton.isHidden = hide
        self.lastButton.isHidden = hide
        self.nextButton.isHidden = hide
        self.hideButton.isHidden = hide
    }
    
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

       
        // Drawing code here.
    }
    @IBAction func buttonClickHome(_ sender: NSButton) {
        currentIndex = 0
        reloadContent(index: currentIndex)
        self.callBack!(0)
    }
    
    @IBAction func buttonClickHide(_ sender: NSButton) {
        hideContent = !hideContent
        self.contentTextView.isHidden = hideContent
    }
    
    
    @IBAction func buttonClickLast(_ sender: NSButton) {
        currentIndex = currentIndex - 1
        if currentIndex <= 0 {
            currentIndex = 0
        }
        
        if currentIndex >= (self.course?.Items.count ?? 1) - 1 {
            currentIndex = (self.course?.Items.count ?? 1) - 1
        }
        reloadContent(index: currentIndex)
    }
    
    
    @IBAction func buttonClickNext(_ sender: NSButton) {
           currentIndex = currentIndex + 1
           if currentIndex <= 0 {
               currentIndex = 0
           }
           
           if currentIndex >= (self.course?.Items.count ?? 1) - 1 {
               currentIndex = (self.course?.Items.count ?? 1) - 1
           }
         reloadContent(index: currentIndex)
       }
    @IBAction func changeContent(_ sender: NSButton) {
        isChinese = !isChinese
        sender.image = isChinese ? NSImage.init(named: "中01") : NSImage.init(named: "中02")
        guard let item:DetailCourse = self.course?.Items?[currentIndex] else{return}
        let text = isChinese ? item.chinese! : item.english!
        let attributeString = NSAttributedString.init(string: text, attributes: [NSAttributedString.Key.font:NSFont.systemFont(ofSize: 16)])
        self.contentTextView.textStorage?.setAttributedString(attributeString)
        self.contentTextView.setAlignment(.left, range: NSRange.init(location: 0, length: self.contentTextView.attributedString().length))
    }
    
    
    
    func showContent(course:Course,index:Int)  {
        self.course = course
        reloadContent(index: index)
       }
    
    
    func reloadContent(index:Int)  {
        guard let item:DetailCourse = self.course?.Items[index] else{return}
           currentIndex = index
        self.changeButton.image = isChinese ? NSImage.init(named: "中01") : NSImage.init(named: "中02")
        self.changeButton.isHidden = false
         titleLabel.stringValue = item.title!
         tips.stringValue = item.tips!
        let text = isChinese ? item.chinese! : item.english!
        
         let attributeString = NSAttributedString.init(string: text, attributes: [NSAttributedString.Key.font:NSFont.systemFont(ofSize: 16)])
         self.contentTextView.textStorage?.setAttributedString(attributeString)
         self.contentTextView.setAlignment(.left, range: NSRange.init(location: 0, length: self.contentTextView.attributedString().length))
        
        self.imageView.image = NSImage.init(named: item.image!)
    }
    
}
