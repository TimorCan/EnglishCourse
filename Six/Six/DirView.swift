//
//  DirView.swift
//  Six
//
//  Created by Jax on 2021/1/7.
//  Copyright © 2021 luxshare-ict. All rights reserved.
//

import Cocoa

class DirView: NSView {

    
    var callBack:((Int)->())?
    var course:Course?
    
    @IBOutlet var custmerView: NSView!
    
    @IBOutlet weak var btn1: NSButton!
    @IBOutlet weak var btn2: NSButton!
    @IBOutlet weak var btn3: NSButton!
    @IBOutlet weak var btn4: NSButton!
    
    
    
    @IBAction func buttonCLick(_ sender: Any) {
        
        let btn = sender as! NSButton
        let tag = btn.tag / 10000 - 1
        self.callBack!(tag)
        
    }
    
    
    //init from xib
   required init?(coder: NSCoder) {
       super.init(coder: coder)
       
       if Bundle.main.loadNibNamed("DirView", owner: self, topLevelObjects: nil) {
              addSubview(custmerView)
          }
       
   }
    
    
    func showBtn(course:Course)  {
        
        if course.Items.count != 4 {
             self.btn1.title = "error"
             self.btn2.title = "error"
             self.btn3.title = "error"
             self.btn4.title = "error"
            return
        }
        self.course = course
        self.btn1.title = course.Items[0].title!
        self.btn2.title = course.Items[1].title!
        self.btn3.title = course.Items[2].title!
        self.btn4.title = course.Items[3].title!
        
    }
    
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
