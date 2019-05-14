//
//  BaseViewController.swift
//  SearchController
//
//  Created by jps on 2019/5/9.
//  Copyright © 2019 jps. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn1 = UIButton(type: .system)
        btn1.setTitle("sizeToFit", for: .normal)
        btn1.addTarget(self, action: #selector(item1Click), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        let item2 = UIBarButtonItem(title: "prominent", style: .done, target: self, action: #selector(item2Click))
        let item3 = UIBarButtonItem(title: "minimal", style: .done, target: self, action: #selector(item3Click))

        self.navigationItem.rightBarButtonItems = [item1, item2, item3]
    }
    
    
    
    @objc func item1Click() {
        
    }
    
    @objc func item2Click() {
        
    }
    
    
    @objc func item3Click() {
        
    }
}
