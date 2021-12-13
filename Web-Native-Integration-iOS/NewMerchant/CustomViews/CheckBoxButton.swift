//
//  CheckBoxButton.swift
//  WebViewNativeCommIos
//
//  Created by Kodakandla, Pradeep on 10/28/21.

import UIKit

class CheckBoxButton: UIButton {

    let checkedImage = UIImage(named: "checkedImage")! as UIImage
    let uncheckedImage = UIImage(named: "uncheckedImage")! as UIImage
    
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
        
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
        
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }

}
