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

class MerchantRequests {
    
    func initRequest(selectedCards: String, srcDpaId:String) -> String {
        return  """
            {
                      "srcDpaId": "\(srcDpaId)",
                      "cardBrands": [
                        \(selectedCards)
                      ],
                      "dpaTransactionOptions": {
                        "dpaAcceptedBillingCountries": [],
                        "dpaAcceptedShippingCountries": [],
                        "dpaBillingPreference": "FULL",
                        "dpaShippingPreference": "FULL",
                        "dpaLocale": "en_US",
                        "consumerNameRequested": true,
                        "consumerEmailAddressRequested": true,
                        "consumerPhoneNumberRequested": true,
                        "threeDsPreference": "NONE",
                        "paymentOptions": [
                          {
                            "dpaDynamicDataTtlMinutes": 15,
                            "dynamicDataType": "CARD_APPLICATION_CRYPTOGRAM_SHORT_FORM"
                          }
                        ],
                        "transactionAmount": {
                          "transactionAmount": 100,
                          "transactionCurrencyCode": "USD"
                        },
                      },
                      "dpaData": {
                        "dpaPresentationName": "Vitrine Test Merchant 1",
                        "dpaName": "Vitrine Test Merchant 1"
                      }
                    }
            """
    }
    
    func encryptCardRequest(cardNumber: String, expiryDate: String, cvc: String) -> String {
        let expiryArr = expiryDate.components(separatedBy: "/")
        let expMo = expiryArr[0]
        let expYr = expiryArr[1]

        let encryptCardRequestString = """
        {
        "primaryAccountNumber": "\(cardNumber)",
        "panExpirationMonth": "\(expMo)",
        "panExpirationYear": "\(expYr)",
        "cardSecurityCode": "\(cvc)",
          "cardholderFirstName": "Jane",
          "cardholderLastName": "Doe",
          "billingAddress": {
            "name": "Jane Doe",
            "line1": "150 Fifth Ave",
            "line2": "string",
            "line3": "string",
            "city": "New York",
            "state": "NY",
            "zip": "10011",
            "countryCode": "US"
        },
        }
        """
        return encryptCardRequestString
    }
    
}
