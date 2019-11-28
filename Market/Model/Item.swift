//
//  Item.swift
//  Market
//
//  Created by Dheeraj Arora on 12/11/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import Foundation

class Item {
    var id: String!
    var categoryId: String!
    var name: String!
    var discription: String!
    var price: Double!
    var imageLinks: [String]!
    
    init() {
        
    }
    
    init(dictionary: NSDictionary) {
        id = dictionary[ObjectId] as? String
        categoryId = dictionary[CategoryId] as? String
        name = dictionary[Name] as? String
        discription = dictionary[Discription] as? String
        price = dictionary[Price] as? Double
        imageLinks = dictionary[imageLinks] as? [String]
        
    }
  
}
//MARK: Save items function
func saveItemsToFirestore(item: Item) {
    FirebaseReference(_collectionReference: .Items).document(item.id).setData(itemDictionaryForm(item: item) as! [String : Any])
}
//MARK: Helper Functions
func  itemDictionaryForm(item: Item) -> NSDictionary {
    return NSDictionary(objects: [item.id, item.categoryId, item.name, item.discription, item.price, item.imageLinks], forKeys: [ObjectId as NSCopying, CategoryId as NSCopying,Name as NSCopying, Discription as NSCopying,Price as NSCopying,ImageLink as NSCopying])
}

//MARK: Download Item Function
func downloadItemFromFirebase(withCategoryId: String, completion: @escaping(_ itemArray: [Item]) -> Void) {
    var itemArray: [Item] = []
    FirebaseReference(_collectionReference: .Items).whereField(CategoryId, isEqualTo: withCategoryId).getDocuments { (snapshot, error) in
        guard let snapshot = snapshot else{
            completion(itemArray)
            return
        }
        if !snapshot.isEmpty{
            for itemDict in snapshot.documents{
                itemArray.append(Item(dictionary: itemDict.data() as NSDictionary))
            }
        }
        completion(itemArray)
    }
}
