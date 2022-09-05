//
//  ViewController.swift
//  SharePhotos
//
//  Created by Hasan Uysal on 3.09.2022.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passText: UITextField!
    
    var alertCreator = AlertCreator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }

    @IBAction func signInBtn(_ sender: Any) {
        
        if emailText.text != "" {
            if passText.text != "" {
                
                Auth.auth().signIn(withEmail: emailText.text!, password: passText.text!) { authDataResult, error in
                    if error != nil {
                        let alert = self.alertCreator.createAlert(title: "Error", msg: error?.localizedDescription ?? "Can't sign in")
                        self.present(alert, animated: true)
                    } else {
                        self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    }
                }
                
            } else {
                let alert = self.alertCreator.createAlert(title: "Error", msg: "Please enter a password")
                self.present(alert, animated: true)
            }
        } else {
            let alert = self.alertCreator.createAlert(title: "Error", msg: "Please enter your e-mail address")
            self.present(alert, animated: true)
        }
        
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        
        if emailText.text != "" {
            if passText.text != "" {
                
                Auth.auth().createUser(withEmail: emailText.text!, password: passText.text!) { autDataResult, error in
                    if error != nil {
                        let alert = self.alertCreator.createAlert(title: "Error", msg: error?.localizedDescription ?? "User can't be created")
                        self.present(alert, animated: true)
                        
                    } else {
                        self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    }
                }
                
            } else {
                
                let alert = self.alertCreator.createAlert(title: "Error", msg: "Please enter a password")
                self.present(alert, animated: true)
            }
        } else {
            alertMsg(title: "Error", msg: "Please enter your e-mail address",view: self)
        }
        
    }
    
    func alertMsg(title: String, msg: String, view: UIViewController){
        
        let alert = self.alertCreator.createAlert(title: title, msg: msg)
        view.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func closeKeyboard(){
        view.endEditing(true)
    }
}

