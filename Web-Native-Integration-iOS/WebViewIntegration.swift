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

import Foundation
import WebKit

class WebViewIntegration : WKWebView, WKScriptMessageHandler {
    
    var callback : (_ response: String?) -> Void = {(response) -> Void in }
    
    init() {
        super.init(frame: CGRect.zero, configuration: WKWebViewConfiguration())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }
    
    func setup() {
        
        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            
            self.configuration.preferences.javaScriptEnabled = true
            
            self.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
        
        self.contentMode = .scaleToFill
        self.isOpaque = false
        self.scrollView.contentInsetAdjustmentBehavior = .never
        
        let contentController = WKUserContentController()

        self.configuration.userContentController = contentController

        self.configuration.userContentController.add(self, name: "jsMessageHandler")
        syncCookies()
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        self.callback(message.body as? String)
    }
    
    func syncCookies() {
//        add dummy cookie to webview to sync cookies
        let cookie = HTTPCookie(properties: [
            .domain: "sandbox.src.mastercard.com",
            .path: "/srci/merchant/2/lib.js?dpaId=&locale=en_US",
            .name: "MyCookieName",
            .value: "MyCookieValue",
            .secure: "TRUE",
            .expires: NSDate(timeIntervalSinceNow: 31556926)
        ])!
        self.configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
    }
    
    func initSdk(request initRequestString: String, callback: @escaping (_ response: String?) -> Void) {
        self.callback = callback
        self.evaluateJavaScript("initSdk(\"ios\", JSON.stringify(\(initRequestString)))")
    }
    
    func encryptCard(request encryptCardRequestString: String, callback: @escaping (_ response: String?) -> Void) {
        self.callback = callback
        self.evaluateJavaScript("encryptCard(\"ios\", JSON.stringify(\(encryptCardRequestString)))")
    }
    
    func checkoutWithNewCard(request checkoutRequestString: String, callback: @escaping (_ response: String?) -> Void) {
        self.callback = callback
        let isActionSheet = UserDefaults.standard.bool(forKey: "isDCFActionSheet")
        self.evaluateJavaScript("checkoutWithNewCard(\"ios\", JSON.stringify(\(checkoutRequestString)),\(isActionSheet))")
    }
    
    func getCards(callback: @escaping (_ response: String?) -> Void) {
        self.callback = callback
        self.evaluateJavaScript("getCards(\"ios\")")
    }
    
    func idLookup(request idLookupRequestString: String, callback: @escaping (_ response: String?) -> Void) {
        self.callback = callback
        self.evaluateJavaScript("idLookup(\"ios\", JSON.stringify(\(idLookupRequestString)))")
    }
    
    func initiateValidation(request initateValidationRequestString: String, callback: @escaping (_ response: String?) -> Void) {
        self.callback = callback
        self.evaluateJavaScript("initiateValidation(\"ios\", JSON.stringify(\(initateValidationRequestString)))")
    }
    
    func validate(request validateRequestString: String, callback: @escaping (_ response: String?) -> Void) {
        self.callback = callback
        self.evaluateJavaScript("validate(\"ios\", JSON.stringify(\(validateRequestString)))")
    }
    
    func checkoutWithCard(request checkoutRequestString: String, callback: @escaping (_ response: String?) -> Void) {
        self.callback = callback
        let isActionSheet = UserDefaults.standard.bool(forKey: "isDCFActionSheet")
        self.evaluateJavaScript("checkoutWithCard(\"ios\", JSON.stringify(\(checkoutRequestString)),\(isActionSheet))")
    }
    
}

