//
//  CardListCell.swift
//  CordovaPluginTest
//
//  Created by Chiu, Amanda on 5/3/21.
//  Copyright © 2021 AmandaChiu. All rights reserved.
//

import UIKit

class CardListCell: UITableViewCell {
    
    @IBOutlet weak var cardArtView: UIImageView!
    @IBOutlet weak var presentationCardNameLabel: UILabel!
    @IBOutlet weak var cardInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
