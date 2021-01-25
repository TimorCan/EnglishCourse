//
//  AppDelegate.swift
//  Six
//
//  Created by Jax on 2021/1/5.
//  Copyright © 2021 luxshare-ict. All rights reserved.
//

import Cocoa
import TSAppKit
//import RealmSwift

import Swift


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let tsVc = TSPreferencesController.init()
    var window:NSWindow?
    var MainWindowVC:MainWindowVC?
    var mainVC:MainSplitVC?
    var lcoalVC:LocalViewController?
    var detailVC:DetailViewController?
//    let realm = try! Realm()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
//        let realm = try! Realm()
//        let path = "Contents/Resources/pptx.plist"
//        let url:URL = Bundle.main.bundleURL.appendingPathComponent(path)
//        guard let data = try? Data.init(contentsOf: url)else{return}
//        guard  let json:[[String:Any]] = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [[String:Any]] else{
//            return
//        }
//        let  jsonData :Data! = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        
        
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            NSApp.activate(ignoringOtherApps: false)
            self.window?.makeKeyAndOrderFront(self)
        }
        return true
    }
    
    @IBAction func showPreferAction(_ sender: Any) {
        
        tsVc.showWindow(sender)
        
    }
    @IBAction func showHelp(sender:Any) {
        
//        [[ sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.cnblogs.com"]];
        NSWorkspace.shared.open(URL.init(string: "https://github.com/TimorCan/EnglishCourse")!)
    }
}

