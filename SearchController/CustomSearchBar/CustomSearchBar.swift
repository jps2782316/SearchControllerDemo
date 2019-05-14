//
//  CustomSearchBar.swift
//  SearchController
//
//  Created by jps on 2019/4/25.
//  Copyright © 2019 jps. All rights reserved.
//

import UIKit

protocol CustomSearchBarDelegate: class {
    @discardableResult
    func searchBarShouldBeginEditing(_ searchBar: CustomSearchBar) -> Bool
    
    func searchBarDidBeginEditing(_ searchBar: CustomSearchBar)
    
    @discardableResult
    func searchBarShouldEndEditing(_ searchBar: CustomSearchBar) -> Bool
    
    func searchBarDidEndEditing(_ searchBar: CustomSearchBar)
    
    func searchBar(_ searchBar: CustomSearchBar, textDidChange text: String)
    
    @discardableResult
    func searchBar(_ searchBar: CustomSearchBar, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    
    @discardableResult
    func searchBarShouldClear(_ searchBar: CustomSearchBar) -> Bool
    
    ///点击键盘上的搜索按钮时调用
    @discardableResult
    func searchBarShouldReturn(_ searchBar: CustomSearchBar) -> Bool
    
    //点击搜索框右边取消按钮时调用
    func searchBarCancelButtonClick(_ searchBar: CustomSearchBar)
}
extension CustomSearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: CustomSearchBar) -> Bool { return true }
    
    func searchBarDidBeginEditing(_ searchBar: CustomSearchBar) {}
    
    func searchBarShouldEndEditing(_ searchBar: CustomSearchBar) -> Bool { return true }
    
    func searchBarDidEndEditing(_ searchBar: CustomSearchBar) {}
    
    func searchBar(_ searchBar: CustomSearchBar, textDidChange text: String) {}
    
    func searchBar(_ searchBar: CustomSearchBar, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { return true }
    
    func searchBarShouldClear(_ searchBar: CustomSearchBar) -> Bool { return true }
    
    func searchBarShouldReturn(_ searchBar: CustomSearchBar) -> Bool { return true }
    
    func searchBarCancelButtonClick(_ searchBar: CustomSearchBar) {}
}


class CustomSearchBar: UIView {

    weak var delegate: CustomSearchBarDelegate?
    
    var text: String? {
        didSet {
            let txt = text ?? ""
            textField.text = txt
            if txt.count > 0 {
                let _ = self.textFieldShouldBeginEditing(textField)
            }
        }
    }
    
    var placeHolder: String = "" {
        didSet {
            buttonCenter.setTitle(placeHolder, for: .normal)
            buttonCenter.sizeToFit()
            buttonCenter.center = textField.center
        }
    }
    
    var showCancelBtn: Bool = true
    
    var textColor: UIColor = .black {
        didSet {
            textField.textColor = textColor
        }
    }
    
    var font: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            textField.font = font
            buttonCenter.titleLabel?.font = font
            buttonCenter.sizeToFit()
        }
    }
    
    var placeholderColor: UIColor = .lightGray {
        didSet {
            let attrString = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
            textField.attributedPlaceholder = attrString
            buttonCenter.setTitleColor(placeholderColor, for: .normal)
        }
    }
    
    var inputAccessoryView1: UIView? {
        didSet {
            guard let accessoryView = inputAccessoryView1 else { return }
            textField.inputAccessoryView = accessoryView
        }
    }
    
    
    let searchBarHeight: CGFloat = 44
    let textFieldHeight: CGFloat = 28
    let searchBarmargin: CGFloat = 8
    
    /** 1.输入框 */
    var textField: UITextField!
    /** 2.取消按钮 */
    var cancelButton: UIButton!
    /** 3.搜索图标 */
    lazy var imageIconView: UIImageView = {
        //搜索图标
        let imageView = UIImageView(image: UIImage(named: "icon_STSearchBar"))
        imageView.isHidden = true
        return imageView
    }()
    /** 4.中间视图 */
    var buttonCenter: UIButton!
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUI()
    }
    
    
    func setUI() {
        var rect = self.frame
        rect.size.height = searchBarHeight
        self.frame = rect
        
        initializeComponents()
        
        self.addSubview(cancelButton)
        self.addSubview(textField)
        self.addSubview(buttonCenter)
        
    }
    
    
    //MARK:  ------------  Action  ------------
    
    @objc func cancelBtnClick(_ sender: UIButton) {
        textField.text = ""
        textField.resignFirstResponder()
        delegate?.searchBarCancelButtonClick(self)
    }
    
    
    //MARK:  ------------  Other  ------------
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }
    
    @discardableResult
    override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }
    
    
    //MARK:  ------------  UI  ------------
    
    func initializeComponents() {
        //搜索框
        let textField = UITextField(frame: CGRect(x: searchBarmargin, y: searchBarmargin, width: self.frame.size.width-searchBarmargin*2, height: textFieldHeight))
        textField.delegate = self
        textField.borderStyle = .none
        textField.contentVerticalAlignment = .center
        textField.returnKeyType = .search
        textField.enablesReturnKeyAutomatically = true
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.clearButtonMode = .whileEditing
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.autoresizingMask = .flexibleWidth
        textField.layer.cornerRadius = 4.0
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.layer.borderWidth = 0.5
        textField.backgroundColor = .white
        textField.leftViewMode = .always
        textField.leftView = imageIconView
        textField.clipsToBounds = true
        self.textField = textField
        
        //取消按钮
        let buttonCancel = UIButton(type: .custom)
        buttonCancel.frame = CGRect(x: self.frame.size.width, y: 0, width: 60, height: searchBarHeight)
        buttonCancel.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        buttonCancel.addTarget(self, action: #selector(cancelBtnClick(_:)), for: .touchUpInside)
        buttonCancel.setTitle("取消", for: .normal)
        buttonCancel.setTitleColor(UIColor.gray, for: .normal)
        buttonCancel.setTitleColor(UIColor.orange, for: .highlighted)
        buttonCancel.autoresizingMask = .flexibleLeftMargin
        cancelButton = buttonCancel
        
        //中间按钮
        let buttonCenter = UIButton(type: .custom)
        buttonCenter.setImage(UIImage(named: "icon_STSearchBar"), for: .normal)
        //buttonCenter.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        //buttonCenter.setTitle("取消", for: .normal)
        buttonCenter.setTitleColor(UIColor.gray, for: .normal)
        buttonCenter.isEnabled = false
        buttonCenter.autoresizingMask = .flexibleLeftMargin
        buttonCenter.sizeToFit()
        self.buttonCenter = buttonCenter
        
    }
    
    
    
    
}


extension CustomSearchBar: UITextInputTraits {

}



//MARK:  输入框代理
extension CustomSearchBar: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        var rect = buttonCenter.frame
        rect.origin.x = textField.frame.minX
        UIView.animate(withDuration: 0.3, animations: {
            self.buttonCenter.frame = rect
            if self.showCancelBtn {
                self.cancelButton.frame = CGRect(x: self.frame.size.width - 60, y: 0, width: 60, height: self.searchBarHeight)
                self.textField.frame = CGRect(x: self.searchBarmargin,
                                              y: self.searchBarmargin,
                                              width: self.cancelButton.frame.origin.x - self.searchBarmargin,
                                              height: self.textFieldHeight)
            }
        }) { (finished) in
            self.buttonCenter.isHidden = true
            self.imageIconView.isHidden = false
            let attrString = NSAttributedString(string: self.placeHolder, attributes: [NSAttributedString.Key.foregroundColor: self.placeholderColor])
            self.textField.attributedPlaceholder = attrString
        }
        
        self.delegate?.searchBarShouldBeginEditing(self)
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.delegate?.searchBarDidBeginEditing(self)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.delegate?.searchBarShouldEndEditing(self)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        buttonCenter.isHidden = false
        imageIconView.isHidden = true
        let attrString = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: self.placeholderColor])
        self.textField.attributedPlaceholder = attrString
        UIView.animate(withDuration: 0.3, animations: {
            if self.showCancelBtn {
                self.cancelButton.frame = CGRect(x: self.frame.size.width, y: 0, width: 60, height: self.searchBarHeight)
                self.textField.frame = CGRect(x: self.searchBarmargin,
                                              y: self.searchBarmargin,
                                              width: self.frame.size.width-self.searchBarmargin*2,
                                              height: self.textFieldHeight)
            }
            self.buttonCenter.center = self.textField.center
        }, completion: nil)
        
        self.delegate?.searchBarDidEndEditing(self)
        
        self.textField.text = ""
    }
    
    //这个不是代理方法
    @objc func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text ?? ""
        if text.count > 0 {
            cancelButton.isHighlighted = true
        }else {
            cancelButton.isHighlighted = false
        }
        self.delegate?.searchBar(self, textDidChange: text)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        delegate?.searchBar(self, shouldChangeCharactersIn: range, replacementString: string)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        delegate?.searchBarShouldClear(self)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        delegate?.searchBarShouldReturn(self)
        
        return true
    }
    
}
