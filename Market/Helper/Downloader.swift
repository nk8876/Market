//
//  Downloader.swift
//  Market
//
//  Created by Dheeraj Arora on 12/11/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import Foundation
import FirebaseStorage

let storage = Storage.storage()

func uploadImage(images: [UIImage?], itemId: String, completion: @escaping(_ imageLinks: [String]) -> Void)  {
    if Reachability.isConnectedToNetwork(){

        var uploadImageCount = 0
        var imageLinkArray: [String] = []
        var nameSuffix = 0
        for image in images{
            let fileName = "ItemImages/" + itemId + "/" + "\(nameSuffix)" + ".jpg"
            let imageData = image!.jpegData(compressionQuality: 0.5)
            saveImageInFirebase(imageData: imageData!, fileName: fileName) { (imageLinks) in
                if ImageLink != nil{
                    imageLinkArray.append(ImageLink)
                    uploadImageCount += 1
                    if uploadImageCount  == images.count{
                        completion(imageLinkArray)
                    }
                }
                nameSuffix += 1
            }
        }
    }else{
        print("No Internet Connection")
    }
    
    
}

func saveImageInFirebase(imageData: Data, fileName: String, completion: @escaping(_ imageLinks: String?) -> Void)  {
    var task: StorageUploadTask!
    let storageRef = storage.reference(forURL: fileReference).child(fileName)
    task = storageRef.putData(imageData, metadata: nil, completion: { (metaData, error) in
        task.removeAllObservers()
        if error != nil
        {
            print("Error Uploading Image", error!.localizedDescription)
            completion(nil)
            return
        }
        storageRef.downloadURL(completion: { (url, error) in
            guard let downloadUrl  = url else {
                completion(nil)
                return
            }
            completion(downloadUrl.absoluteString)
        })
    })
}

func downloadImages(imageUrls: [String], completion: @escaping(_ images:[UIImage?]) -> Void)   {
    var imageArray: [UIImage] = []
    var downloaderCountr = 0
    
    for link in imageUrls {
        let url = URL(string: link)
        let downloadQueue = DispatchQueue(label: "imageDownloadQueue")
        downloadQueue.async {
            downloaderCountr += 1
            do {
                let imageData = try Data(contentsOf: url! as URL)
                if imageData != nil{
                    imageArray.append(UIImage(data: imageData as Data)!)
                    if downloaderCountr == imageArray.count{
                        DispatchQueue.main.async {
                            completion(imageArray)
                        }
                    }
                }else{
                    print("Could not download image")
                    completion(imageArray)
                }
                
            } catch {
                print("Unable to load data: \(error)")
            }
            
        }
        
    }
}
