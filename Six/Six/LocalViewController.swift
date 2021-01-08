//JCSelectVC

import Cocoa
//import FatSidebar
//struct OmniFocusTheme: FatSidebarTheme {
//
//    let itemStyle: FatSidebarItemStyle = OmniFocusItemStyle()
//    let sidebarBackground = OmniFocusTheme.backgroundColor
//
//    static var selectedColor: NSColor { return #colorLiteral(red: 0.901724875, green: 0.9334430099, blue: 0.9331719875, alpha: 1) }
//    static var recessedColor: NSColor { return #colorLiteral(red: 0.682291925, green: 0.6823920608, blue: 0.68227005, alpha: 1) }
//    static var backgroundColor: NSColor { return #colorLiteral(red: 0.7919496894, green: 0.8197044134, blue: 0.8194655776, alpha: 1) }
//
//    struct OmniFocusItemStyle: FatSidebarItemStyle {
//
//        let background = StatefulColor(
//            normal:      OmniFocusTheme.backgroundColor,
//            selected:    OmniFocusTheme.selectedColor,
//            highlighted: OmniFocusTheme.recessedColor)
//
//        let borders = Borders(
//            bottom: StatefulColor(single: OmniFocusTheme.recessedColor),
//            right: StatefulColor(
//                normal:      OmniFocusTheme.recessedColor,
//                selected:    OmniFocusTheme.selectedColor,
//                highlighted: OmniFocusTheme.recessedColor))
//    }
//}
struct NewItem {
    static var empty: NewItem { return NewItem(title: "", image: nil, tintColor: nil) }
    var title: String = ""
    var image: NSImage?
    var tintColor: NSColor?
}




func templated(_ image: NSImage) -> NSImage {
    let result = image.copy() as! NSImage
    result.isTemplate = true
    return result
}

extension SavedSearch {
    static var defaultImage: NSImage {
        return templated(#imageLiteral(resourceName: "layers.png"))
    }

    init(fromNewItem newItem: NewItem) {
        self.init(
            title: newItem.title,
            image: newItem.image ?? SavedSearch.defaultImage,
            tintColor: newItem.tintColor)
    }

    var newItem: NewItem {
        return NewItem(title: self.title, image: self.image, tintColor: self.tintColor)
    }
}


class LocalViewController: NSViewController,FatSidebarDelegate{
    
    @IBOutlet weak var fatSidebar: FatSidebar!
    
    var selectLeftIndex:Int = 0
    
    @IBOutlet weak var rightContentView: NSView!
    
    
    @IBOutlet weak var dirView: DirView!
    
    @IBOutlet weak var contentView: ContentView!
    //FatSlider dataSource
    var savedSearches: [SavedSearch] = []
    
    var course:[Course] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let app:AppDelegate = NSApplication.shared.delegate as! AppDelegate
        app.lcoalVC = self
        
         //UI
        // Do view setup here.
        fatSidebar.delegate = self
//        fatSidebar.theme = OmniFocusTheme()
        fatSidebar.style = .small(iconSize: 33, padding: 10)
        fatSidebar.selectionMode = .toggleOne
//        fatSidebar.sidebarContextualMenu = itemContextualMenu
//        fatSidebar.itemContextualMenu = itemContextualMenu
        relaodLeftItem()
        showRightView(start: 0)
    }
    
    
    
    
 
    
    
    func relaodLeftItem()  {
        let path = "Contents/Resources/pptx.plist"
        let url:URL = Bundle.main.bundleURL.appendingPathComponent(path)
        guard let data = try? Data.init(contentsOf: url)else{return}
        guard  let json:[[String:Any]] = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [[String:Any]] else{
            return
        }
        let  jsonData :Data! = try? JSONSerialization.data(withJSONObject: json, options: [])

        
        self.course.removeAll()
        let decoder = JSONDecoder()
        do {
            let product = try decoder.decode([Course].self, from: jsonData)
            self.course = product.reversed()
            
         } catch {
            print(error)
        }
        
        
       
      
        savedSearches.removeAll()
        
        
        
        for item in  self.course{
            
            let m =  SavedSearch(title: item.title!,
                                 image: templated(#imageLiteral(resourceName: "ppt")),
                                 tintColor: NSColor.init(red: 230/255.0, green: 38/255.0, blue: 48/255.0, alpha: 1))
            savedSearches.append(m)
        }
        replaceSidebarWithModel()

    }
    
    
    
    
    
    
    fileprivate func replaceSidebarWithModel() {

        fatSidebar.removeAllItems()
        for savedSearch in savedSearches {
            fatSidebar.appendItem(savedSearch)
        }
    
    }
    
    

    
    

    
    


}


extension LocalViewController{
    
    func showRightView(start startIndex:Int){
        
        
        DispatchQueue.main.async {
            
            self.contentView.isHidden = true
            self.contentView.hiddenButton(hide: true)
            self.dirView.isHidden = false
            
            self.dirView.showBtn(course: self.course[startIndex])
            self.contentView.hiddenButton(hide: true)
            self.contentView.callBack = { _ in
                self.contentView.isHidden = true
                self.contentView.hiddenButton(hide: true)
                self.dirView.isHidden = false
            }
            self.dirView.callBack = { tag in
                self.contentView.showContent(course: self.course[startIndex], index: tag)
                self.contentView.isHidden = false
                self.contentView.hiddenButton(hide: false)
                self.dirView.isHidden = true
            }
        }
        
        
        
        
    }
    
    
}




extension LocalViewController{
    func sidebar(_ sidebar: FatSidebar, didMoveItemFrom oldIndex: Int, to newIndex: Int) {

        guard oldIndex != newIndex else { return }

        let item = savedSearches.remove(at: oldIndex)
        savedSearches.insert(item, at: newIndex)
    }



    func sidebar(_ sidebar: FatSidebar, didChangeSelection selectionIndex: Int) {

        Swift.print("Selected \(savedSearches[selectionIndex])")
    }

    func sidebar(_ sidebar: FatSidebar, didPushItem selectionIndex: Int) {
        sidebar.selectItem(at: selectionIndex)
        if selectLeftIndex == selectionIndex{
            return
        }
        selectLeftIndex = selectionIndex
        showRightView(start: selectionIndex)

    }

//    func sidebar(_ sidebar: FatSidebar, didRemoveItem index: Int) {
//
//        self.savedSearches.remove(at: index)
//        self.replaceSidebarWithModel()
//    }
}



