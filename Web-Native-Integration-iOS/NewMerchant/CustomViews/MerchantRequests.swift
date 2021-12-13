//
//  MerchantRequests.swift
//  WebViewNativeCommIos
//
//  Created by Kodakandla, Pradeep on 10/29/21.

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
