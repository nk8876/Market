//
//  ItemDetailCollectionViewCell.swift
//  Market
//
//  Created by Dheeraj Arora on 14/11/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import UIKit

class ItemDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    
    func setupImageWidth(image: UIImage)   {
        itemImage.image = image
    }
    
}
