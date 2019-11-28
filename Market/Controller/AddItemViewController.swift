//
//  AddItemViewController.swift
//  Market
//
//  Created by Dheeraj Arora on 12/11/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import UIKit
import Gallery
import JGProgressHUD
import NVActivityIndicatorView

class AddItemViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var txtItemTitle: UITextField!
    @IBOutlet weak var txtItemPrice: UITextField!
    @IBOutlet weak var txtItemDiscription: UITextView!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnDone: UIBarButtonItem!
    
    
    //MARK: Vars
    var category: Category!
    var itemImages: [UIImage?] = []
    var gallery: GalleryController!
    var hud = JGProgressHUD(style: .dark)
    var activityIndicator: NVActivityIndicatorView?
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = " "

        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width / 2 - 30, y: self.view.frame.height / 2 - 30, width: 60, height: 60), type: .ballPulse, color: UIColor(red:0.9998469949, green:4941213727, blue:4734867811, alpha:1), padding: nil)
    }
    @IBAction func brnDoneAction(_ sender: Any) {
        dismissKeyboard()
        if fieldsAreCompleted(){
            saveToFirebase()
        }else{
            print("All fields are required")
            //TODO: SHOW ERROR TO THE USER
            self.hud.textLabel.text = "All fields are required"
            self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
            self.hud.show(in: self.view)
            self.hud.dismiss(afterDelay: 2.0)
        }
    }
    
    @IBAction func btnCameraButtonPressed(_ sender: Any) {
        itemImages = []
        showImageGallery()
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        dismissKeyboard()
    }
    
    //MARK: Helper Function
    func fieldsAreCompleted()-> Bool{
        return (txtItemTitle.text != "" && txtItemPrice.text != "" && txtItemDiscription.text != "")
    }
     func dismissKeyboard(){
        self.view.endEditing(false)
    }
    
    func popUpView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Save Item
    func saveToFirebase() {
        self.showLoadingIndicaror()
        let item = Item()
        item.id = UUID().uuidString
        item.name = txtItemTitle.text
        item.categoryId = category.id
        item.discription = txtItemDiscription.text
        item.price = Double(txtItemPrice.text!)
        
        if itemImages.count > 0{
            uploadImage(images: itemImages, itemId: item.id) { (imageLinkArray) in
                item.imageLinks = imageLinkArray
                saveItemsToFirestore(item: item)
                self.hideLoadingIndicaror()
                self.popUpView()
            }
        }else{
          saveItemsToFirestore(item: item)
            popUpView()
        }
    }
    
    //MARK: Activity Indicator
    func  showLoadingIndicaror() {
        if activityIndicator != nil{
            self.view.addSubview(activityIndicator!)
            	activityIndicator!.startAnimating()
        }
    }
    func  hideLoadingIndicaror() {
        if activityIndicator != nil{
            activityIndicator!.removeFromSuperview()
            activityIndicator!.stopAnimating()
        }
    }
    
    //MARK: Show Gallery
    func showImageGallery() {
        self.gallery = GalleryController()
        self.gallery.delegate = self
        Config.tabsToShow = [.imageTab, .cameraTab]
        Config.Camera.imageLimit = 6
        self.present(self.gallery, animated: true, completion: nil)
    }
}


extension AddItemViewController: GalleryControllerDelegate{
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        if images.count > 0{
           Image.resolve(images: images) { (resolvedImages) in
                self.itemImages = resolvedImages
            }
        }
        controller.dismiss(animated: true, completion: nil)

    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        controller.dismiss(animated: true, completion: nil)

    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        controller.dismiss(animated: true, completion: nil)

    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
