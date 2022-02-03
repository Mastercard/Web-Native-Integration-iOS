/* Copyright © 2022 Mastercard. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 =============================================================================*/

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
