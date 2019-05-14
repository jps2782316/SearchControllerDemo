//
//  SearchResultViewController.swift
//  SearchController
//
//  Created by jps on 2019/4/24.
//  Copyright © 2019 jps. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    
    var tableView: UITableView!
    
    //保存搜索结果的数组数据
    var resultArray: [String] = [] {
        didSet  { self.tableView.reloadData() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    
    func setUI() {
        
        //创建表视图
        let tableViewFrame = CGRect(x: 0, y: 0, width: self.view.frame.width,
                                    height: self.view.frame.height)
        self.tableView = UITableView(frame: tableViewFrame)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView!)
        
        
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.definesPresentationContext = true
        
        //不写这里tableVie顶部会直接空出导航栏+状态栏的高度
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }

    

}


extension SearchResultViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                     for: indexPath)
            cell.textLabel?.text = resultArray[indexPath.row]
            cell.contentView.backgroundColor = UIColor.red
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
