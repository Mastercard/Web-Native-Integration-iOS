//
//  MaskedCard.swift
//  CordovaPluginTest
//
//  Created by Chiu, Amanda on 5/5/21.
//  Copyright © 2021 AmandaChiu. All rights reserved.
//

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
