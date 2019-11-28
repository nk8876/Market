//
//  ItemListTableViewCell.swift
//  Market
//
//  Created by Dheeraj Arora on 13/11/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import UIKit

class ItemListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemDiscription: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func generateCell(item: Item)  {
        itemTitle.text = item.name
        itemDiscription.text = item.discription
        itemPrice.text = convertToCurrency(number: item.price)
        itemPrice.adjustsFontSizeToFitWidth = true

        if item.imageLinks != nil && item.imageLinks.count > 0{
            downloadImages(imageUrls: [item.imageLinks.first!]) { (images) in
                self.itemImage.image = images.first!
            }
        }
    }

}
