//
//  SettingsViewController.swift
//  SharePhotos
//
//  Created by Hasan Uysal on 5.09.2022.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {
   
    @IBOutlet weak var userNameLabel: UILabel!
    
    var alertCreator = AlertCreator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        userNameLabel.text = Auth.auth().currentUser?.email
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOutBtn(_ sender: Any) {
        
        
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toVC", sender: nil)
        } catch {
            let alert = alertCreator.createAlert(title: "Error", msg: "Can't Sign Out")
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
    }
    
   

}
