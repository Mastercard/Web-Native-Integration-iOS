//
//  RequestResponseView.swift
//  WebViewNativeCommIos
//
//  Created by Kodakandla, Pradeep on 10/28/21.

import UIKit

class RequestResponseView: UIView {
    @IBOutlet var inputTextField: UITextField?
    @IBOutlet var requestButton: UIButton?
    @IBOutlet var requestTextView: UITextView?
    @IBOutlet var responseTextView:UITextView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateView() {
        requestTextView?.layer.cornerRadius = 5
        requestTextView?.layer.borderWidth = 2.0
        requestTextView?.layer.borderColor = UIColor.gray.cgColor

        responseTextView?.layer.cornerRadius = 5
        responseTextView?.layer.borderWidth = 2.0
        responseTextView?.layer.borderColor = UIColor.gray.cgColor
        
        requestButton?.layer.cornerRadius = 5
        inputTextField?.borderStyle = .line
    }
}
