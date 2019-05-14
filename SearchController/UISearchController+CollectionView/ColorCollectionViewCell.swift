//
//  ColorCollectionViewCell.swift
//  SearchController
//
//  Created by jps on 2019/5/6.
//  Copyright © 2019 jps. All rights reserved.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    var titleLable: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUI()
    }
    
    
    
    func setUI() {
        titleLable = UILabel()
        titleLable.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        titleLable.textAlignment = .center
        titleLable.backgroundColor = UIColor.red
        titleLable.numberOfLines = 0
        contentView.addSubview(titleLable)
    }
}
