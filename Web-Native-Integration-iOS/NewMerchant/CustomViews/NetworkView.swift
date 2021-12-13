//
//  NetworkView.swift
//  WebViewNativeCommIos
//
//  Created by Kodakandla, Pradeep on 10/28/21.

import UIKit

class NetworkView: UIView {
    @IBOutlet weak var masterCardButton: CheckBoxButton?
    @IBOutlet weak var visaButton: CheckBoxButton?
    @IBOutlet weak var amexButton: CheckBoxButton?
    @IBOutlet weak var discoverButton: CheckBoxButton?
    @IBOutlet weak var actionSheetButton:CheckBoxButton?
}

class CardView: UIView {
    @IBOutlet var cardNumberTextField: UITextField?
    @IBOutlet var expTextField: UITextField?
    @IBOutlet var cvcTextField: UITextField?
    @IBOutlet var encryptCardView: RequestResponseView?
    @IBOutlet var checkoutWithNewCardView: RequestResponseView?
    
    func updateView() {
        self.encryptCardView?.updateView()
        self.checkoutWithNewCardView?.updateView()
    }
}

class GetCardsView: UIView {
    @IBOutlet var getCardsButton: UIButton?
    @IBOutlet var cardsTableView: UITableView?
    @IBOutlet weak var requestTextView: UITextView?
    @IBOutlet weak var responseTextView: UITextView?
    
    @IBOutlet var checkoutCardView: RequestResponseView?
    
    func updateView() {
        requestTextView?.layer.cornerRadius = 5
        requestTextView?.layer.borderWidth = 2.0
        requestTextView?.layer.borderColor = UIColor.gray.cgColor

        responseTextView?.layer.cornerRadius = 5
        responseTextView?.layer.borderWidth = 2.0
        responseTextView?.layer.borderColor = UIColor.gray.cgColor
        self.checkoutCardView?.updateView()
    }

}
