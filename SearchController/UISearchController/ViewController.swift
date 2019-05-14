//
//  ViewController.swift
//  SearchController
//
//  Created by jps on 2019/4/24.
//  Copyright © 2019 jps. All rights reserved.
//

import UIKit
//https://www.hangge.com/blog/cache/detail_797.html Swift - 使用UISearchController实现带搜索栏的表格
//https://www.hangge.com/blog/cache/detail_562.html Swift - 搜索条（UISearchBar）的用法
//https://www.hangge.com/blog/cache/detail_2277.html Swift - 实现带有搜索框的导航栏（将UISearchController集成到Navigation上）

//https://www.hangge.com/blog/cache/detail_1293.html Swift - 在表格头部添加一个带范围选择（scope bar）的搜索栏


//https://juejin.im/post/5b722c9c6fb9a009be253abc iOS UISearchController样式全面设置


//https://juejin.im/entry/5a0d445cf265da4314404182 iOS--UISearchBar 属性、方法详解及应用（自定义搜索框样式）


//自定义搜索框 http://code.cocoachina.com/view/132561

class ViewController: UIViewController {
    
    
    //展示列表
    var tableView: UITableView!
    //搜索控制器
    var countrySearchController = UISearchController()
    
    //搜索结果控制器
    //let resultVC = 
    
    //原始数据集
    let schoolArray = ["Q清华大学","b北京大学","中国人民大学","北京交通大学","北京工业大学",
                       "北京航空航天大学","北京理工大学","北京科技大学","中国政法大学",
                       "中央财经大学","华北电力大学","北京体育大学","上海外国语大学","复旦大学",
                       "华东师范大学","上海大学","河北工业大学"]
    
    //搜索过滤后的结果集
    var searchArray:[String] = [String](){
        didSet  { self.tableView.reloadData() }
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }

    
    
    
    func setUI() {
        let tableViewFrame = CGRect(x: 0, y: 0, width: self.view.frame.width,
                                    height: self.view.frame.height)
        self.tableView = UITableView(frame: tableViewFrame, style:.plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView)
        
        
        //配置搜索控制器
        self.countrySearchController = ({
            //是否给一个结果视图控制器用来显示搜索结果；给nil没有视图控制器显示结果，所以用当前视图控制器显示搜索结果
            let controller = UISearchController(searchResultsController: nil)
            controller.delegate = self
            controller.searchResultsUpdater = self   //两个样例使用不同的代理(实时搜索)
            controller.searchBar.delegate = self  //两个样例使用不同的代理(点击见怕搜索按钮)
            //进入搜索状态时，是否隐藏导航栏
            controller.hidesNavigationBarDuringPresentation = true
            //设置背景颜色是否变灰 (默认是YES)
            controller.dimsBackgroundDuringPresentation = false
            
            //设置搜索框自适应屏幕
            controller.searchBar.sizeToFit()
            //设置搜索框的背景颜色
            controller.searchBar.barTintColor = UIColor.blue
            //背景图
            controller.searchBar.backgroundImage = UIImage(named: "searchBarBackground2.jpg")
            //.minimal时，没有默认的背景，设置barTintColor不生效
            controller.searchBar.searchBarStyle = .prominent
            
            //设置搜索框的提示文字
            controller.searchBar.placeholder = "请输入关键字"
            
            //配置分段条
            controller.searchBar.scopeButtonTitles = ["全部", "动作", "爱情", "动画"]
            
            //设置左边按钮图标
            //controller.searchBar.setImage(UIImage(named: "record"), for: UISearchBar.Icon.search, state: UIControl.State.normal)
            //设置右边按钮
            controller.searchBar.showsBookmarkButton = true
            controller.searchBar.setImage(UIImage(named: "record"), for: UISearchBar.Icon.bookmark, state: UIControl.State.normal)
            controller.searchBar.showsSearchResultsButton = true
            controller.searchBar.setImage(UIImage(named: "record"), for: UISearchBar.Icon.resultsList, state: UIControl.State.normal)
            
            ///用UISearchController，设置取消按钮又不生效
            controller.searchBar.showsCancelButton = true
            
            
            //这里也无法设置取消按钮的值
            //countrySearchController.searchBar.setValue("取消", forKey: "cancelButtonText")
            
            ///用UISearchController，(设置true一开始就会显示cancel按钮，设置false跟没设置一样)
            //controller.searchBar.showsCancelButton = true
            //不调用这句，下面kvc就取不到取消按钮
            controller.searchBar.setShowsCancelButton(false, animated: true)
            //修改searchBar取消按钮的文字、颜色 (现在取到的值为nil了)
            if let cancelBtn = controller.searchBar.value(forKey: "cancelButton") as? UIButton {
                cancelBtn.setTitle("取消", for: .normal)
                cancelBtn.setTitleColor(UIColor.orange, for: .normal)
                cancelBtn.backgroundColor = UIColor.orange
            }
            
            //修改searchBar取消按钮的文字、颜色 (可以通过更改UISearchBar中包含的UIBarButtonItem的外观来更改“取消”按钮样式。)
            let attributes = [
                NSAttributedString.Key.foregroundColor : UIColor.yellow,
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)
            ]
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
            
            
            if let searchField = controller.searchBar.value(forKey: "searchField") as? UITextField {
                //修改搜索框文字颜色
                searchField.textColor = UIColor.blue
                //修改光标颜色
                searchField.tintColor = UIColor.green
                searchField.backgroundColor = UIColor.red
                //设置圆角
                searchField.layer.cornerRadius = 20
                searchField.layer.masksToBounds = true
            }
            
            
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        
        
    }
    
    
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.countrySearchController.isActive {
            return self.searchArray.count
        } else {
            return self.schoolArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                     for: indexPath)
            
            if self.countrySearchController.isActive {
                cell.textLabel?.text = self.searchArray[indexPath.row]
                return cell
            } else {
                cell.textLabel?.text = self.schoolArray[indexPath.row]
                return cell
            }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}



extension ViewController: UISearchResultsUpdating {
    //实时进行搜索
    func updateSearchResults(for searchController: UISearchController) {
        searchArray = schoolArray.filter({ (schoolName) -> Bool in
            guard let serchStr = searchController.searchBar.text else { return false }
            return schoolName.contains(serchStr)
        })
        

    }
    
}
extension ViewController: UISearchBarDelegate {
    //搜索代理UISearchBarDelegate方法，点击虚拟键盘上的Search按钮时触发
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //searchBar.resignFirstResponder()
        searchArray = schoolArray.filter({ (schoolName) -> Bool in
            guard let searchStr = searchBar.text else { return false }
            return schoolName.contains(searchStr)
        })
    }
    //点击取消按钮
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchArray = schoolArray
    }
    
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    //范围分段条的选中项改变事件
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    
    // 搜索代理UISearchBarDelegate方法，每次改变搜索内容时都会调用
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let serchStr = searchText
        if serchStr == "" {
            //没内容时候显示全部
            searchArray = schoolArray
        }else {
            //匹配用户输入内容的前缀(不区分大小写)
            var tempArr: [String] = []
            for s in schoolArray {
                if s.lowercased().hasPrefix(serchStr.lowercased()) {
                    tempArr.append(s)
                }
            }
            searchArray = tempArr
        }
        
    }
    
    //不实用searchController在这里设置才会生效
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //隐藏取消按钮，必须在这里设才生效
        //countrySearchController.searchBar.showsCancelButton = false
    }
    
    
    
    
}


extension ViewController: UISearchControllerDelegate {
    //当我们希望彻底隐藏掉取消按钮的时候，应该怎么做呢？经过测试发现，只有在 UISearchController 的 delegate 中的 didPresentSearchController(_) 实现内调用可以实现隐藏取消按钮。
    func didPresentSearchController(_ searchController: UISearchController) {
        //searchController.searchBar.setShowsCancelButton(false, animated: false)
    }
    
    
    /*
     文字居中
     在iOS 11之前，UISearchBar默认是居中的，在iOS 11之后改为居左，并且没有直接的API可以设置对齐方式。系统提供了一个API可以调整搜索放大镜的位置：
     实现思路是设置放大镜的PositionAdjustment，当搜索处于激活状态再将PositionAdjustment设为Zero。
     */
    func willPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.setPositionAdjustment(UIOffset.zero, for: .search)
        
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        
        searchController.searchBar.setPositionAdjustment(UIOffset(horizontal: 100, vertical: 0), for: .search)
    }
    
}
