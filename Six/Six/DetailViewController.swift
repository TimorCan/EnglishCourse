//
//  DetailViewController.swift
//  Six
//
//  Created by Jax on 2021/1/5.
//  Copyright © 2021 luxshare-ict. All rights reserved.
//

import Cocoa
import Kingfisher


class DetailViewController: NSViewController {

    var item:DetailList?
    @IBOutlet weak var tableView: NSTableView!
    var change = false
    
   
    var count = 2
    var play_URL = "" //播放连接
  
    
    
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
        
        guard let nib3:NSNib = NSNib.init(nibNamed: "SoundCell", bundle: nil) else {return}
        self.tableView.register(nib3, forIdentifier: NSUserInterfaceItemIdentifier(rawValue: "SoundCell"))
        
        
        let app:AppDelegate = NSApplication.shared.delegate as! AppDelegate
         app.detailVC = self
        
    }
    
    func refreshUIByModel(theModel list:DetailList)  {
        self.item = list
        if  let url = list.data.url {
            self.count = 3
            self.play_URL = url
        }else{
            self.count = 2
        }
        self.tableView.reloadData()
    }
}



extension DetailViewController:NSTableViewDelegate,NSTableViewDataSource{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        if row == 0 {
            return 200
        }
        
        if self.count == 3 && self.play_URL != "" && row == 1 {
            return 40
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
        
        if self.count == 3 && self.play_URL != "" && row == 1 {
            let cell:SoundCell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "SoundCell"), owner: nil) as! SoundCell
            cell.url = self.play_URL
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


