//
//  ViewController2.swift
//  SearchController
//
//  Created by jps on 2019/4/24.
//  Copyright © 2019 jps. All rights reserved.
//

import UIKit


class ViewController2: UIViewController {
    
    
    //展示列表
    var tableView: UITableView!
    //搜索控制器
    var countrySearchController = UISearchController()
    
    //搜索结果控制器
    let resultVC = SearchResultViewController()
    
    //原始数据集
    let schoolArray = ["Q清华大学","b北京大学","中国人民大学","北京交通大学","北京工业大学",
                       "北京航空航天大学","北京理工大学","北京科技大学","中国政法大学",
                       "中央财经大学","华北电力大学","北京体育大学","上海外国语大学","复旦大学",
                       "华东师范大学","上海大学","河北工业大学"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        
        
        
        
    }
    
    
    
    
    func setUI() {
        //创建表视图
        let tableViewFrame = CGRect(x: 0, y: 0, width: self.view.frame.width,
                                    height: self.view.frame.height)
        self.tableView = UITableView(frame: tableViewFrame, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView!)
        
        //不写这句,resultVC头顶会空出一截
        //self.navigationController?.navigationBar.isTranslucent = false
        self.definesPresentationContext = true
        
        //配置搜索控制器
        self.countrySearchController = ({
            //是否给一个结果视图控制器用来显示搜索结果；给nil没有视图控制器显示结果，所以用当前视图控制器显示搜索结果
            let controller = UISearchController(searchResultsController: resultVC)
            controller.searchResultsUpdater = self
            controller.delegate = self
            controller.searchBar.delegate = self
            controller.hidesNavigationBarDuringPresentation = true
            //controller.searchBar.searchBarStyle = .minimal
            //设置搜索框自适应屏幕
            controller.searchBar.sizeToFit()
            //设置背景颜色是否变灰 (默认是YES)
            controller.dimsBackgroundDuringPresentation = true
            //设置搜索框的提示文字
            controller.searchBar.placeholder = "请输入关键字"
            //设置搜索框的背景颜色
           // controller.searchBar.barTintColor = UIColor.blue
            
//            controller.searchBar.showsSearchResultsButton = true
//            controller.searchBar.setImage(UIImage(named: "record"), for: UISearchBar.Icon.resultsList, state: UIControl.State.normal)
            
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        
        //self.navigationItem.titleView = searchController.searchBar
    }
    
    
    
}


extension ViewController2: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.schoolArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                     for: indexPath)
            cell.textLabel?.text = self.schoolArray[indexPath.row]
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}



extension ViewController2: UISearchResultsUpdating {
    //实时进行搜索
    func updateSearchResults(for searchController: UISearchController) {
        resultVC.resultArray.removeAll()
        resultVC.resultArray = schoolArray.filter({ (schoolName) -> Bool in
            guard let serchStr = searchController.searchBar.text else { return false }
            return schoolName.contains(serchStr)
        })
    }
    
}

extension ViewController2: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        
    }
}

extension ViewController2: UISearchBarDelegate {
    //搜索代理UISearchBarDelegate方法，点击虚拟键盘上的Search按钮时触发
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        resultVC.resultArray = schoolArray.filter({ (schoolName) -> Bool in
            guard let searchStr = searchBar.text else { return false }
            return schoolName.contains(searchStr)
        })
    }
    //点击取消按钮
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resultVC.resultArray = schoolArray
    }
    
    // 搜索代理UISearchBarDelegate方法，每次改变搜索内容时都会调用
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
    }
    
}
