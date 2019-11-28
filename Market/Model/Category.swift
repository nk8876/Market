//
//  Category.swift
//  Market
//
//  Created by Dheeraj Arora on 11/11/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import Foundation
import UIKit

class Category {
    var id: String
    var name: String
    var image: UIImage?
    var imageName: String?
    
    init(_name: String, _imageName: String) {
        id = ""
        name = _name
        imageName = _imageName
        image = UIImage(named: _imageName)
      
    }
    
    init(dictionary: NSDictionary) {
        id = dictionary[ObjectId] as! String
        name = dictionary[Name] as! String
        image = UIImage(named: dictionary[ImageName] as? String ?? "")
        
    }
    
}

//MARK: SAVE CATEGORY FUNCTION
func saveCategoryToFirebase(category: Category) {
    let id = UUID().uuidString
    category.id = id
    FirebaseReference(_collectionReference: .Category).document(id).setData(categoryDictionaryForm(category: category) as! [String : Any])
}

//MARK:HELPER
func categoryDictionaryForm(category: Category)-> NSDictionary{
    return NSDictionary(objects: [category.id, category.name, category.imageName ?? ""], forKeys: [ ObjectId as NSCopying,Name as NSCopying, ImageName as NSCopying])
    
}


//MARK: Download Category from firebase
func downlaodCategoriesFromFirebase(completion: @escaping (_ categoryArray: [Category])-> Void ) {
    var categoryArray: [Category] = []
    FirebaseReference(_collectionReference: .Category).getDocuments { (snapshot, error) in
        guard let snapshot = snapshot else{
            completion(categoryArray)
            return
        }
        if !snapshot.isEmpty{
            for categoryDict in snapshot.documents{
                categoryArray.append(Category(dictionary: categoryDict.data() as NSDictionary))
            }
        }
        completion(categoryArray)
    }
}

//Used only one time
//func  createCategorySet() {
//    let woman_clothing = Category(_name: "Women's Clothing & Accessories", _imageName: "womenCloth")
//    let footWear = Category(_name: "Foot Wear", _imageName: "footWear")
//    let electronics = Category(_name: "Electronics", _imageName: "electronics")
//    let men_clothing = Category(_name: "Men's Clothing & Accessories", _imageName: "menCloth")
//    let health = Category(_name: "Heath & Beauty", _imageName: "health")
//    let baby = Category(_name: "Baby Stuff", _imageName: "baby")
//    let home = Category(_name: "Home & Kichen", _imageName: "home")
//    let car = Category(_name: "Automobiles & Motorcycles", _imageName: "car")
//    let luggage = Category(_name: "Luggage & Bags", _imageName: "luggage")
//    let jewelery = Category(_name: "Jewelery", _imageName: "jewelery")
//    let hobby = Category(_name: "Hobby, Sports & Traveling", _imageName: "hobby")
//    let pet = Category(_name: "Pet Product", _imageName: "pet")
//    let indusry = Category(_name: "Industry & Business", _imageName: "indusry")
//    let garden = Category(_name: "Gerden Supplies", _imageName: "gerden")
//    let camera = Category(_name: "Cameras & Optics", _imageName: "camera")
//
//    let arrayOfCategory = [woman_clothing,footWear,electronics,
//                           men_clothing,health,baby,home,car,
//                           luggage,jewelery,hobby,pet,indusry,
//                           garden,camera,
//                        ]
//    for category in arrayOfCategory{
//        saveCategoryToFirebase(category: category)
//    }
//}
