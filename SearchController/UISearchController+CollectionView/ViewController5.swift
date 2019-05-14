//
//  ViewController5.swift
//  SearchController
//
//  Created by jps on 2019/5/6.
//  Copyright © 2019 jps. All rights reserved.
//
import UIKit

class ViewController5: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    
    //原始数据集
    let schoolArray = ["Q清华大学","b北京大学","中国人民大学","北京交通大学","北京工业大学",
                       "北京航空航天大学","北京理工大学","北京科技大学","中国政法大学",
                       "中央财经大学","华北电力大学","北京体育大学","上海外国语大学","复旦大学",
                       "华东师范大学","上海大学","河北工业大学"]
    
    //搜索过滤后的结果集
    var searchArray:[String] = [String](){
        didSet  {
            print(searchArray)
            self.collectionView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: "ColorCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.sizeToFit()
        searchController.searchBar.becomeFirstResponder()
        self.navigationItem.titleView = searchController.searchBar
        
        self.definesPresentationContext = true
        
        
        searchArray = schoolArray
    }
    
   
    
    
}

extension ViewController5: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchArray = schoolArray
    }
    
    //点击取消按钮的时候也会走这里
    func updateSearchResults(for searchController: UISearchController)
    {
        searchArray = schoolArray.filter({ (schoolName) -> Bool in
            guard let serchStr = searchController.searchBar.text else { return false }
            return schoolName.contains(serchStr)
        })
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        
    }
}



extension ViewController5: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath) as! ColorCollectionViewCell
        
        cell.contentView.layer.cornerRadius = 7.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.cornerRadius = 7.0
        let str = searchArray[indexPath.row]
        cell.titleLable.text = str
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
}


