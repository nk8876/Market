//
//  CategoryCollectionViewController.swift
//  Market
//
//  Created by Dheeraj Arora on 11/11/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CategoryCollectionViewController: UICollectionViewController {
    
    //MARK: Vars
    var categoryArray: [Category] = []
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    let itemPerRow: CGFloat = 3
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
         self.title = "All Category"
    
    }

    override func viewDidAppear(_ animated: Bool) {
        loadAllCategory()
    }
   
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return categoryArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        cell.generateCell(category: categoryArray[indexPath.row])
        return cell
    }

    //MARK: UICollectionViewdDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     performSegue(withIdentifier: "categoryToItemsSeg", sender: categoryArray[indexPath.row])
        
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoryToItemsSeg"{
            let vc = segue.destination as! ItemsTableViewController
            vc.category = (sender as! Category)
        }
    }
    //MARK: Download categories
    func  loadAllCategory() {
        downlaodCategoriesFromFirebase { (allCategory) in
            self.categoryArray = allCategory
            self.collectionView.reloadData()
        }
    }
}


extension CategoryCollectionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemPerRow + 1)
        let availabeWith = view.frame.width - paddingSpace
        let widthPerItem = availabeWith / itemPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
