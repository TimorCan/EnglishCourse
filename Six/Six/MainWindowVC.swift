//
//  MainWindowVC.swift
//  Six
//
//  Created by Jax on 2021/1/6.
//  Copyright © 2021 luxshare-ict. All rights reserved.
//

import Cocoa
import CommonCrypto
import CoreGraphics

class MainWindowVC: NSWindowController {

    @IBOutlet weak var print: NSToolbarItem!
    @IBOutlet weak var k: NSToolbarItem!
    @IBOutlet weak var six: NSToolbarItem!
    @IBOutlet weak var toolBar: NSToolbar!
    
//    var detailVC:DetailViewController?
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        let app:AppDelegate = NSApplication.shared.delegate as! AppDelegate
        app.window = self.window
        app.MainWindowVC = self
        
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
     
    }
    
    
    @IBAction func sixAction(_ sender: Any) {
        
        Swift.print("six")
        let app:AppDelegate = NSApplication.shared.delegate as! AppDelegate
        guard let vc = app.mainVC else {
            return
        }
        self.contentViewController = vc
        
    }
    @IBAction func kAction(_ sender: Any) {
        let app:AppDelegate = NSApplication.shared.delegate as! AppDelegate
        if app.lcoalVC == nil {
            let sb:NSStoryboard = NSStoryboard.init(name: "Local", bundle: nil)
            let vc = sb.instantiateInitialController() as! LocalViewController
           self.contentViewController = vc
        }
        self.contentViewController = app.lcoalVC
        
        Swift.print("k")
    }
    
    @IBAction func printAction(_ sender: Any) {
        
        let app:AppDelegate = NSApplication.shared.delegate as! AppDelegate
        guard let detailVC = app.detailVC else{return}
         
       
      
    
        //导出详情
        detailVC.view.lockFocus()
        
        let image = NSImage.init(data: detailVC.view.dataWithPDF(inside: detailVC.view.bounds))
        
        detailVC.view.unlockFocus()
        image?.lockFocus()
        let bits = NSBitmapImageRep.init(focusedViewRect: detailVC.tableView.bounds)
        image?.unlockFocus()
        
        
        let pngData = bits?.representation(using: .png, properties: [:])
        
        
        let panel = NSSavePanel.init()
        panel.allowedFileTypes = ["png"]
        panel.prompt = "保存位置"
        panel.nameFieldLabel = "保存文件名字"
        panel.nameFieldStringValue = "\(Date())".md5
        panel.message = "保存详情页"
        panel.beginSheetModal(for: NSApplication.shared.keyWindow ?? NSApplication.shared.windows[0], completionHandler: { (result) in
            if result == .OK{
                if let url = panel.url{
                   try! pngData?.write(to: url)
                }
                 
            }
        })
        
    }
    

}

extension String
{
    var md5: String
    {
        let ccharArray = self.cString(using: String.Encoding.utf8)
    
        var uint8Array = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        
        CC_MD5(ccharArray, CC_LONG(ccharArray!.count - 1), &uint8Array)
        
        return uint8Array.reduce("") { $0 + String(format: "%02X", $1)
        }
    }
}
