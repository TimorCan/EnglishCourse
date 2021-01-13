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
    
    @IBOutlet weak var tableView: NSTableView!
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
        guard let nib:NSNib = NSNib.init(nibNamed: "DetailIConCellView", bundle: nil) else {return}
                                 self.tableView.register(nib, forIdentifier: NSUserInterfaceItemIdentifier(rawValue: "DetailIConCellView"))
        
        guard let nib2:NSNib = NSNib.init(nibNamed: "DetailTextCellView", bundle: nil) else {return}
        self.tableView.register(nib2, forIdentifier: NSUserInterfaceItemIdentifier(rawValue: "DetailTextCellView"))
        
        let app:AppDelegate = NSApplication.shared.delegate as! AppDelegate
         app.detailVC = self
//         self.textContent.stringValue = ""
        
    }
    
    func refreshUIByModel(theModel list:DetailList)  {
        self.item = list
        self.tableView.reloadData()
//        self.image.kf.indicatorType = .activity
//        self.image.kf.setImage(with: URL.init(string: list.data.image._url!)!)
//        let text:NSString = list.data?.text as NSString? ?? "error" as NSString
//        let height = text.size(withAttributes: [NSAttributedString.Key.font : NSFont.init(name: "PingFang SC", size: 14) ?? NSFont.systemFont(ofSize: 14)]).height
//        var heightf:CGFloat = 0.0
//        if heightf < 399 {
//            heightf = 656.0
//        }else{
//            heightf = 656.0 - 399.0 + height + 50.0
//        }
//
////        self.contentView.frame = NSMakeRect(0, 0, 450, heightf)
//        self.labelHeightConstant.constant = heightf
//
//        scrollView.documentView = self.contentView
////        self.scrollView.setNeedsDisplay(scrollView.frame)
//        self.textContent.stringValue = text as String
        
        
//
//        let attributeString = NSAttributedString.init(string: list.data.text ?? "error", attributes: [NSAttributedString.Key.font:NSFont.systemFont(ofSize: 15)])
//        self.textContent.textStorage?.setAttributedString(attributeString)
//        self.textContent.setAlignment(.center, range: NSRange.init(location: 0, length: self.textContent.attributedString().length))
    }
    
//    @IBAction func change(_ sender: Any) {
//        change = !change
//
//        if change {
//            self.widthConstant.constant = 1000
//        }else{
//            self.widthConstant.constant = 450
//        }
//
//
//    }
    
    
}

extension DetailViewController:NSTableViewDelegate,NSTableViewDataSource{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        if row == 0 {
            return 200
        }
        let str = self.item?.data.text ?? "..."
        let height = str.size(withAttributes: [NSAttributedString.Key.font : NSFont.init(name: "PingFang SC", size: 14) ?? NSFont.systemFont(ofSize: 14)]).height
        if height < 399 {
             return 399
        }
        return (height + 50)
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        
        if row == 0  {
            let cell:DetailIConCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "DetailIConCellView"), owner: nil) as! DetailIConCellView
            guard let urlStr:String = self.item?.data.image._url  else {
                return cell
            }
            guard let url:URL = URL.init(string: urlStr) else {
                return cell
            }
            
            cell.iconView.kf.indicatorType = .activity
            cell.iconView.kf.setImage(with:url)
            return cell
        }
        
        let cell:DetailTextCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "DetailTextCellView"), owner: nil) as! DetailTextCellView
        cell.titlesLabel.stringValue = self.item?.data.text ?? ""
        
        return cell
        
    }
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return MyNSTableRowView()
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        
//        print(notification)
//        let row = self.tableView.selectedRow
//        let item:DetailList = self.dataSource[row]
//
//        let noti = Notification.init(name: NSNotification.Name(rawValue: "DeialItemChange"), object: item)
//        NotificationCenter.default.post(noti as Notification)
        
    }
}


