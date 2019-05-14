//
//  HomeViewController.swift
//  SearchController
//
//  Created by jps on 2019/5/6.
//  Copyright © 2019 jps. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
    @IBAction func searchControllerBtnClick(_ sender: Any) {
        let vc = ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func searchControllerResultBtnClick(_ sender: Any) {
        let vc = ViewController2()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func searchBarBtnClick(_ sender: Any) {
        let vc = ViewController3()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func customSearchBarBtnClick(_ sender: Any) {
        let vc = ViewController4()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func searchControllerAndCollectionView(_ sender: Any) {
        let vc = ViewController5()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    

}
