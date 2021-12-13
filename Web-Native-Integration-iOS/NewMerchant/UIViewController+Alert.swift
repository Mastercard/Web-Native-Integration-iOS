//
//  UIViewController+Alert.swift
//  WebViewNativeCommIos
//
//  Created by Kodakandla, Pradeep on 11/2/21.

import Foundation
import UIKit

extension UIViewController {
    func showAlert(message:String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alertController.addAction((UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        })))
        self.present(alertController, animated: true, completion: nil)

    }
}
