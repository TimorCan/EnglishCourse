//
//  AppDelegate.swift
//  Six
//
//  Created by Jax on 2021/1/5.
//  Copyright © 2021 luxshare-ict. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window:NSWindow?
    var MainWindowVC:MainWindowVC?
    var mainVC:MainSplitVC?
    var lcoalVC:LocalViewController?
    var detailVC:DetailViewController?
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
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
    
    @IBAction func showHelp(sender:Any) {
        
//        [[ sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.cnblogs.com"]];
        NSWorkspace.shared.open(URL.init(string: "https://github.com/TimorCan/EnglishCourse")!)
    }
}

