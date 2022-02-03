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
