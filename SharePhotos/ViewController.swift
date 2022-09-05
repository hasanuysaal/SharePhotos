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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInBtn(_ sender: Any) {
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        
        if emailText.text != "" {
            if passText.text != "" {
                
                Auth.auth().createUser(withEmail: emailText.text!, password: passText.text!) { autDataResult, error in
                    if error != nil {
                        self.alertMsg(title: "Error", msg: error?.localizedDescription ?? "User can't be created")
                    } else {
                        self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    }
                }
                
            } else {
                alertMsg(title: "Error", msg: "Please enter a password")
            }
        } else {
            alertMsg(title: "Error", msg: "Please enter your e-mail address")
        }
        
    }
    
    func alertMsg(title: String, msg: String){
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertBtn = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(alertBtn)
        present(alert, animated: true, completion: nil)
        
    }
}

