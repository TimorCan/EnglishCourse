//
//  MainSplitVC.swift
//  Six
//
//  Created by Jax on 2021/1/6.
//  Copyright © 2021 luxshare-ict. All rights reserved.
//

import Cocoa

class MainSplitVC: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let app:AppDelegate = NSApplication.shared.delegate as! AppDelegate
        app.mainVC = self
//        self.splitView.minPossiblePositionOfDivider(at: 150)
//        self.splitView.maxPossiblePositionOfDivider(at: 150)
//        self.splitView(self.splitView, constrainMaxCoordinate: 400, ofSubviewAt: 0)
//        self.splitView(self.splitView, constrainMinCoordinate: 200, ofSubviewAt: 1)
    }
//    override func splitView(_ ofDividerAtsplitView: NSSplitView, effectiveRect proposedEffectiveRect: NSRect, forDrawnRect drawnRect: NSRect, ofDividerAt dividerIndex: Int) -> NSRect {
//        return NSRect.zero
//    }
    
//    override func splitView(_ splitView: NSSplitView, resizeSubviewsWithOldSize oldSize: NSSize) {
//          
//        let dividerThickness = splitView.dividerThickness
//        
//        var leftRect = splitView.subviews.first?.frame
//        var rightRect = splitView.subviews.last?.frame
//        
//        let newFram = splitView.frame
//        
//        leftRect?.size.width = 100
//        leftRect?.size.height = newFram.size.height
//        leftRect?.origin = CGPoint.zero
//        rightRect?.size.width = newFram.size.width - (leftRect?.size.width)! - dividerThickness
//        
//        rightRect?.size.height = newFram.size.height
//        rightRect?.origin.x = (leftRect?.size.width)! + dividerThickness
//        
//        
//        guard  let leftView:NSView = splitView.subviews.first  else{return}
//        leftView.frame = leftRect!
//        
//        guard  let rightView:NSView = splitView.subviews.last  else{return}
//        rightView.frame = rightRect!
//        
//        
//    }
    
//    override func splitView(_ splitView: NSSplitView, constrainMinCoordinate proposedMinimumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
//        if (proposedMinimumPosition < 240)
//        {
//            return  240
//        }
//        return proposedMinimumPosition;
//    }
//
//    override func splitView(_ splitView: NSSplitView, canCollapseSubview subview: NSView) -> Bool {
//        return false
//    }
//
}

