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

public class MaskedCard : Codable {
    var srcDigitalCardId : String?
    var panLastFour : String?
    var digitalCardData : DigitalCardData?
    var dateOfCardCreated : String?
    var dateOfCardLastUsed : String?
    var dcf : DCFInfo?
    var paymentCardType : String?
    var panExpirationMonth : String?
    var panExpirationYear : String?
    
    
    public class DigitalCardData : Codable {
        var status : String?
        var artUri : String?
        var descriptorName : String?
        var presentationName : String?
        var isCoBranded : Bool?
    }
    
    public class DCFInfo : Codable {
        var type : String?
        var uri : String?
        var name : String?
    }
    
    init(
        srcDigitalCardId : String?,
        panLastFour : String?,
        digitalCardData : DigitalCardData?,
        dateOfCardCreated : String?,
        dateOfCardLastUsed : String?,
        dcf : DCFInfo?,
        paymentCardType : String?,
        panExpirationMonth : String,
        panExpirationYear : String
    ) {
        self.srcDigitalCardId = srcDigitalCardId
        self.panLastFour = panLastFour
        self.digitalCardData = digitalCardData
        self.dateOfCardCreated = dateOfCardCreated
        self.dateOfCardLastUsed = dateOfCardLastUsed
        self.dcf = dcf
        self.paymentCardType = paymentCardType
        self.panExpirationMonth = panExpirationMonth
        self.panExpirationYear = panExpirationYear
    }
        
}
