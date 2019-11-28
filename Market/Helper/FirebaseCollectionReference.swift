//
//  FirebaseCollectionReference.swift
//  Market
//
//  Created by Dheeraj Arora on 11/11/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case User
    case Category
    case Items
    case Basket
    
}

func FirebaseReference(_collectionReference: FCollectionReference)-> CollectionReference{
    return Firestore.firestore().collection(_collectionReference.rawValue)
}
