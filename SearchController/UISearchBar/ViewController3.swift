//
//  ViewController3.swift
//  SearchController
//
//  Created by jps on 2019/4/25.
//  Copyright © 2019 jps. All rights reserved.
//

import UIKit




class ViewController3: BaseViewController {
    
    var tableView: UITableView!
    
    var searchBar: UISearchBar!
    
    
    //原始数据集
    let schoolArray = ["Q清华大学","b北京大学","中国人民大学","北京交通大学","北京工业大学",
                       "北京航空航天大学","北京理工大学","北京科技大学","中国政法大学",
                       "中央财经大学","华北电力大学","北京体育大学","上海外国语大学","复旦大学",
                       "华东师范大学","上海大学","河北工业大学"]
    
    //搜索过滤后的结果集
    var searchArray:[String] = [String](){
        didSet  {
            print(searchArray)
            self.tableView.reloadData()
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setUI()
        
        //默认显示所有学校
        searchArray = schoolArray
    }
    
    
    
    
    func setUI() {
        let tableViewFrame = CGRect(x: 0, y: 0, width: self.view.frame.width,
                                    height: self.view.frame.height)
        self.tableView = UITableView(frame: tableViewFrame, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView!)
        
        
        
        
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 100))
        //代理
        searchBar.delegate = self
        
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.definesPresentationContext = true
        
        //设置搜索框自适应屏幕(写了这句自定义的searBar高度就不生效了,写了这句backgroundImage才生效, 还可能导致进入搜索状态的时候searbar位置向下偏移，解决办法是加上上面两句)
        //searchBar.sizeToFit()
        //设置背景图(searchBar.sizeToFit(),才能生效，而如果用UISearchController，则不设置sizeToFit()直接设置背景图也有用)
        //searchBar.backgroundImage = UIImage(named: "searchBarBackground2.jpg")
        searchBar.setBackgroundImage(UIImage(named: "searchBarBackground2.jpg"), for: .any, barMetrics: .default)
        //设置搜索框的背景颜色 (即不设置背景图也不设置barTintColor，系统会自带一个灰色背景)
        searchBar.barTintColor = UIColor.cyan
        
        // 为.minimal时，没有默认的背景(设置barTintColor就不生效,但backgroundImage还是生效的)，输入框是半透明的
        /*
         searchBarStyle共有3种系统样式
         default： 默认样式
         prominent：search bar的背景是半透明的，输入框是不透明的
         minimal：search bar没有默认的背景，输入框是半透明的
         */
        //searchBar.searchBarStyle = .minimal
        
        
        
        
        //设置搜索框的提示文字(如果要设置字体、颜色，可以拿到searchField再设置attributedPlaceholder)
        searchBar.placeholder = "请输入关键字"
        
        //设置左边按钮图标
        searchBar.setImage(UIImage(named: "pictrue"), for: UISearchBar.Icon.search, state: UIControl.State.normal)
        //右边按钮
        searchBar.showsBookmarkButton = true
        searchBar.setImage(UIImage(named: "record"), for: UISearchBar.Icon.bookmark, state: UIControl.State.normal)
        
        
        // 调整输入框高度, 宽度可以设置大于0的任意值，高度为输入框显示高度
        let image = self.searchFieldImage(CGSize.init(width: 100, height: 80))
        //        image = image?.resizableImage(withCapInsets: UIEdgeInsets.init(top: 0, left: 45, bottom: 0, right: 45), resizingMode: UIImageResizingMode.stretch)
        searchBar.setSearchFieldBackgroundImage(image, for: .normal)
        
        //文字居中,
        //在iOS 11之前，UISearchBar默认是居中的，在iOS 11之后改为居左，并且没有直接的API可以设置对齐方式。系统提供了一个API可以调整搜索放大镜的位置：
        searchBar.setPositionAdjustment(UIOffset(horizontal: 100, vertical: 0), for: .search)
        
        //显示取消按钮   (用UISearchController，设置取消按钮又不生效, controller.searchBar.showsCancelButton = false)
        searchBar.showsCancelButton = true
        //修改searchBar取消按钮的文字、颜色 (现在取到的值为nil了)
        //如果用controller.searchBar.value(forKey: "cancelButton")，取到的值为nil
        if let cancelBtn = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelBtn.setTitle("搜索", for: .normal)
            cancelBtn.setTitleColor(UIColor.orange, for: .normal)
        }
        
        //修改searchBar取消按钮的文字、颜色 (可以通过更改UISearchBar中包含的UIBarButtonItem的外观来更改“取消”按钮样式。)
        let attributes = [
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        
        
        if let searchField = searchBar.value(forKey: "searchField") as? UITextField {
            //修改搜索框文字颜色
            searchField.textColor = UIColor.blue
            //设置占位文字的字体颜色
            let attributes2 = [
                NSAttributedString.Key.foregroundColor : UIColor.green,
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)
            ]
            let attrStr = NSAttributedString(string: "请输入关键字", attributes: attributes2)
            searchField.attributedPlaceholder = attrStr
            //修改光标颜色
            searchField.tintColor = UIColor.purple
            searchField.backgroundColor = UIColor.red
            //设置圆角
            searchField.layer.cornerRadius = 20 //searchField.bounds.size.height/2.0 //20
            searchField.layer.masksToBounds = true
            
        }
        
        
        self.tableView.tableHeaderView = searchBar
    }
    
    
    //生成图片方法
    func searchFieldImage(_ size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        UIColor.white.setFill()
        UIRectFill(CGRect.init(origin: CGPoint.zero, size: size))
        // 圆角效果
        //        let path = UIBezierPath.init(roundedRect: CGRect.init(origin: CGPoint.zero, size: size), cornerRadius: size.height / 2)
        //        path.fill()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    override func item1Click() {
        searchBar.sizeToFit()
    }
    
    override func item2Click() {
        searchBar.searchBarStyle = .prominent
        //searchBar.barStyle
    }
    
    override func item3Click() {
        searchBar.searchBarStyle = .minimal
    }
}


extension ViewController3: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                     for: indexPath)
            
            cell.textLabel?.text = self.searchArray[indexPath.row]
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}




extension ViewController3: UISearchBarDelegate {
    
    //点击虚拟键盘上的Search按钮
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchArray = schoolArray.filter({ (schoolName) -> Bool in
            guard let searchStr = searchBar.text else { return false }
            return schoolName.contains(searchStr)
        })
    }
    
    //点击取消按钮
    /*
     如果是使用searchController，点击取消按钮的时候，键盘会自动缩回去，且会触发updateSearchResults(for searchController: UISearchController)这个方法
     */
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchArray = schoolArray
        
        
    }
    
    // 搜索代理UISearchBarDelegate方法，每次改变搜索内容时都会调用
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            //没内容时候显示全部
            print("搜索关键字为空")
            searchArray = schoolArray
        }else {
            print("搜索关键字为\(searchText)")
            searchArray = schoolArray.filter({ (schoolName) -> Bool in
                guard let searchStr = searchBar.text else { return false }
                return schoolName.contains(searchStr)
            })
        }
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            searchBar.setPositionAdjustment(UIOffset.zero, for: .search)
        }else {
            searchBar.setPositionAdjustment(UIOffset(horizontal: 100, vertical: 0), for: .search)
        }
        
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       
        searchBar.setPositionAdjustment(UIOffset.zero, for: .search)
    }
}




// UISearchBar添加位置

/*
 1. 导航栏
 在iOS 11之前UISearchBar通常都是加在tableView的headerView上，但是iOS 11上系统可以将UISearchBar加在导航栏上，效果就和系统信息、通信录的效果一样。
 if #available(iOS 11.0, *) {
 self.navigationItem.searchController = searchController
 navigationItem.hidesSearchBarWhenScrolling = false // 
 } else {
 self.navigationItem.titleView = searchController.searchBar
 }
 
 2. 作为UITableView的tableHeaderView
 self.tableView.tableHeaderView = searchBar
 
 3.添加到其它view
 self.view.addSubview(searchBar)
 */
