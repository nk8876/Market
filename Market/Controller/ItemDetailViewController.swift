//
//  ItemDetailViewController.swift
//  Market
//
//  Created by Dheeraj Arora on 14/11/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import UIKit
import JGProgressHUD
class ItemDetailViewController: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var myCollection: UICollectionView!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemDescription: UITextView!
    
    //MARK: vARS
    var item: Item!
    var itemImages:[UIImage] = []
    let hud = JGProgressHUD(style: .dark)
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addCartButton()
        
    }
    
    //MARK: Setup View
    func setupView()  {
        self.navigationController?.navigationBar.topItem?.title = " "
        if item != nil{
             self.title = item.name
            itemPrice.text = convertToCurrency(number: item.price)
            itemName.text = item.name
            itemDescription.text = item.discription
        }
        
    }

    //MARK: Add cart button and action
    func addCartButton()  {
        let rightBtn = UIBarButtonItem(image: UIImage(named: "cart"), style: .plain, target: self, action: #selector(addItemToCart))
        rightBtn.tintColor = UIColor.darkGray
        self.navigationItem.rightBarButtonItem = rightBtn
        
    }
    //This is cart Action
    @objc func addItemToCart() {
        self.hud.textLabel.text = "Item Added to Cart"
        self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        self.hud.show(in: self.view)
        self.hud.dismiss(afterDelay: 2.0)
    }
    //MARK: Download Pictures
    func downloadPictures()  {
        if item != nil && item.imageLinks != nil{
            downloadImages(imageUrls: item.imageLinks) { (allImages) in
                if allImages.count > 0{
                    self.itemImages = allImages as! [UIImage]
                    self.myCollection.reloadData()
                }
            }
        }
    }
}

extension ItemDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemImages.count == 0 ? 1 : itemImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ItemDetailCollectionViewCell
        if itemImages.count > 0{
            cell.setupImageWidth(image: itemImages[indexPath.row])

        }
        return cell
    }
    
    
}
