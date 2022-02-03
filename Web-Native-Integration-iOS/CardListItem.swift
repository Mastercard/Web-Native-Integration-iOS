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

class CardListItem : Equatable {
    var srcDigitalCardId : String?
    var panLastFour : String?
    var descriptorName : String?
    var artUri : String?
    var panExpirationMonth : String?
    var panExpirationYear : String?
    
    init(
        srcDigitalCardId : String?,
        panLastFour : String?,
        descriptorName : String?,
        artUri : String?,
        panExpirationMonth : String?,
        panExpirationYear : String?
    ) {
        self.srcDigitalCardId = srcDigitalCardId
        self.panLastFour = panLastFour
        self.descriptorName = descriptorName
        self.artUri = artUri
        self.panExpirationMonth = panExpirationMonth
        self.panExpirationYear = panExpirationYear
    }
    
    static func == (lhs: CardListItem, rhs: CardListItem) -> Bool {
        return lhs.srcDigitalCardId == rhs.srcDigitalCardId
    }
}
