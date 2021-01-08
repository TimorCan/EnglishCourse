//
//  ViewController.swift
//  Six
//
//  Created by Jax on 2021/1/5.
//  Copyright © 2021 luxshare-ict. All rights reserved.
//

import Cocoa
import Kingfisher
import UserNotifications


class ViewController: NSViewController {
    var dataSource:[HomeList] = []
    @IBOutlet weak var tableView: NSTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        guard let nib:NSNib = NSNib.init(nibNamed: "HomeCellView", bundle: nil) else {return}
                   self.tableView.register(nib, forIdentifier: NSUserInterfaceItemIdentifier(rawValue: "HomeCellView"))
        getList()
    }
    
    
    
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}


extension ViewController{
    func getList()  {
        self.dataSource.removeAll()
        let path = "Contents/Resources/List.plist"
        let url:URL = Bundle.main.bundleURL.appendingPathComponent(path)
        guard let data = try? Data.init(contentsOf: url)else{return}
        guard  let objs:[String] = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String] else{
            return
        }
        
        
        apiProvider.request(.list) { result in
           if case let .success(response) = result {
               
           let decoder = JSONDecoder()
            do {
                let product = try decoder.decode([HomeList].self, from: response.data)
                
                for item in objs {
                    for obj in product {
                        if item == obj.name {
                            self.dataSource.append(obj)
                        }
                    }
                }
                
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
             } catch {
                print(error)
            }
            
           }
        }
    }
}
extension ViewController:NSTableViewDelegate,NSTableViewDataSource{
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 99
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell:HomeCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "HomeCellView"), owner: nil) as! HomeCellView
        let item:HomeList = self.dataSource[row]
        cell.titleLabel.stringValue = item.publisherName ?? ""
        cell.desLabel.stringValue = item.description ?? ""
        cell.iconView.kf.indicatorType = .activity
        cell.iconView.kf.setImage(with: URL.init(string: item.icon!))
        return cell
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        
        print(notification)
        let row = self.tableView.selectedRow
        let item:HomeList = self.dataSource[row]
        
        let noti = Notification.init(name: NSNotification.Name(rawValue: "ItemChange"), object: item)
        NotificationCenter.default.post(noti as Notification)
        
    }
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return MyNSTableRowView()
    }
    
}
