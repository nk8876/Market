//
//  CategoryCollectionViewCell.swift
//  Market
//
//  Created by Dheeraj Arora on 11/11/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func generateCell(category: Category)  {
        nameLabel.text = category.name
        categoryImage.image = category.image
    }
}
