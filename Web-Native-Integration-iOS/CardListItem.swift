//
//  CardList.swift
//  CordovaPluginTest
//
//  Created by Chiu, Amanda on 5/3/21.
//  Copyright © 2021 AmandaChiu. All rights reserved.
//

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
