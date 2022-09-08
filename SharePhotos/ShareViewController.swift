//
//  ShareViewController.swift
//  SharePhotos
//
//  Created by Hasan Uysal on 5.09.2022.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class ShareViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var labelLoading: UILabel!
    
    var alertCreator = AlertCreator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.hidesWhenStopped = true
        labelLoading.isHidden = true
        
        imageView.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        imageView.addGestureRecognizer(gestureRecognizer)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func shareBtn(_ sender: Any) {
        
        self.spinner.startAnimating()
        self.labelLoading.isHidden = false
        let storage = Storage.storage()
        let storageReferans = storage.reference()
        
        let mediaFolder = storageReferans.child("Media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString
            let imageReferans = mediaFolder.child("\(uuid).jpg")
            
            imageReferans.putData(data, metadata: nil) { storageMetaData, error in
                if error != nil{
                    let alert = self.alertCreator.createAlert(title: "Error", msg: error?.localizedDescription ?? "Photo can't be upload")
                    self.present(alert, animated: true, completion: nil)
                } else {
                    imageReferans.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            if let imageUrl = imageUrl{
                                
                                let fireStoreDB = Firestore.firestore()
                                
                                let fireStorePost = ["imageUrl": imageUrl, "comment": self.commentTextField.text!, "email": Auth.auth().currentUser!.email as Any, "Date": FieldValue.serverTimestamp()] as [String : Any]
                                
                                fireStoreDB.collection("Post").addDocument(data: fireStorePost) { (error) in
                                    if error != nil {
                                        let alert = self.alertCreator.createAlert(title: "Error", msg: error?.localizedDescription ?? "Photo can't be upload")
                                        self.present(alert, animated: true, completion: nil)
                                    } else {
                                        self.labelLoading.isHidden = true
                                        self.spinner.stopAnimating()
                                        let msg = self.alertCreator.createAlert(title: "Success", msg: "The photo shared successfully")
                                        self.present(msg, animated: true, completion: nil)
                                        self.commentTextField.text = ""
                                        self.imageView.image = UIImage(named: "image")
                                        self.tabBarController?.selectedIndex = 0
                                        
                                    }
                                }
                                
                            }
                            
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
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

}
