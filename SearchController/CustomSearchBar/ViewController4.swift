//
//  ViewController4.swift
//  SearchController
//
//  Created by jps on 2019/4/25.
//  Copyright © 2019 jps. All rights reserved.
//

import UIKit

class ViewController4: UIViewController {
    
    var searchBar: CustomSearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar = CustomSearchBar(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width - 40, height: 0))
        searchBar.delegate = self
        searchBar.placeHolder = "高仿系统搜索框"
        searchBar.showCancelBtn = false
        
        self.view.addSubview(searchBar)
        searchBar.becomeFirstResponder()
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.resignFirstResponder()
    }

}


extension ViewController4: CustomSearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: CustomSearchBar) -> Bool {
        return true
    }
    
    func searchBarDidBeginEditing(_ searchBar: CustomSearchBar) {
        
    }
    
    func searchBarShouldEndEditing(_ searchBar: CustomSearchBar) -> Bool {
        return true
    }
    
    func searchBarDidEndEditing(_ searchBar: CustomSearchBar) {
        
    }
    
    func searchBar(_ searchBar: CustomSearchBar, textDidChange text: String) {
        
    }
    
    func searchBar(_ searchBar: CustomSearchBar, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func searchBarShouldClear(_ searchBar: CustomSearchBar) -> Bool {
        return true
    }
    
    func searchBarShouldReturn(_ searchBar: CustomSearchBar) -> Bool {
        return true
    }
}
