//
//  ShareViewController.swift
//  SharePhotos
//
//  Created by Hasan Uysal on 5.09.2022.
//

import UIKit
import FirebaseStorage

class ShareViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    
    var alertCreator = AlertCreator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        imageView.addGestureRecognizer(gestureRecognizer)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func shareBtn(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReferans = storage.reference()
        
        let mediaFolder = storageReferans.child("Media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString
            let imageReferans = mediaFolder.child("\(uuid).jpg")
            
            imageReferans.putData(data) { storageMetaData, error in
                if error != nil{
                    let alert = self.alertCreator.createAlert(title: "Error", msg: error?.localizedDescription ?? "Photo can't be upload")
                    self.present(alert, animated: true, completion: nil)
                } else {
                    imageReferans.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            print(imageUrl)
                        }
                    }
                }
                
            }
        }
        
    }
    
    @objc func choosePhoto(){
            
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        self.dismiss(animated: true)
    }

}
