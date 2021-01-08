//
//  DetailListViewController.swift
//  Six
//
//  Created by Jax on 2021/1/5.
//  Copyright © 2021 luxshare-ict. All rights reserved.
//

import Cocoa
import Kingfisher

class DetailListViewController: NSViewController {
    var dataSource:[DetailList] = []
    @IBOutlet weak var tableView: NSTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "ItemChange"), object: nil, queue: nil) { (notice) in
            print(notice)
            let item:HomeList = notice.object as! HomeList
            guard let name = item.name else{return}
            self.requestListByName(theName: name)
        }
        
        guard let nib:NSNib = NSNib.init(nibNamed: "DetailListCellView", bundle: nil) else {return}
                          self.tableView.register(nib, forIdentifier: NSUserInterfaceItemIdentifier(rawValue: "DetailListCellView"))
        
    }
    
    func requestListByName(theName name:String)  {
        var type:Api = .commapi(name)
        if name == "englishdaily" {
            type = .englishdaily(2080,name)
        }
        
            apiProvider.request(type) { result in
               if case let .success(response) = result {
                   
               let decoder = JSONDecoder()
                do {
                    let product = try decoder.decode([DetailList].self, from: response.data)
                    self.dataSource = product
                    DispatchQueue.main.async {
                        self.tableView.scroll(NSPoint.zero)
                        self.tableView.reloadData()
                    }
                 } catch {
                    print(error)
                }
                
               }
            }
//        }
    }
    
}


extension DetailListViewController:NSTableViewDelegate,NSTableViewDataSource{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 199
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell:DetailListCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "DetailListCellView"), owner: nil) as! DetailListCellView
        let item:DetailList = self.dataSource[row]
        
        cell.titleLabel.stringValue = item.data.title ?? ""
        
        if item.data.title == nil || item.data.title == "" {
            cell.titleLabel.stringValue = item.data.text ?? ""
        }
        
        
        
        cell.imgeView.kf.indicatorType = .activity
        cell.imgeView.kf.setImage(with: URL.init(string: item.data.image.url!))
        return cell
    }
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return MyNSTableRowView()
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        
        print(notification)
        let row = self.tableView.selectedRow
        let item:DetailList = self.dataSource[row]
        
        let noti = Notification.init(name: NSNotification.Name(rawValue: "DeialItemChange"), object: item)
        NotificationCenter.default.post(noti as Notification)
        
    }
}


class MyNSTableRowView: NSTableRowView {
    
    override func drawSelection(in dirtyRect: NSRect) {
        if self.selectionHighlightStyle != .none {
            let selectionRect = NSInsetRect(self.bounds, 2.5, 2.5)
            NSColor(calibratedWhite: 0.65, alpha: 1).setStroke()
            NSColor(calibratedWhite: 0.82, alpha: 1).setFill()
            let selectionPath = NSBezierPath.init(roundedRect: selectionRect, xRadius: 0, yRadius: 0)
            selectionPath.fill()
            selectionPath.stroke()
        }
    }
}
