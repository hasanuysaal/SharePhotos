//
//  ViewController.swift
//  SharePhotos
//
//  Created by Hasan Uysal on 3.09.2022.
//

import UIKit

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
        
        performSegue(withIdentifier: "toFeedVC", sender: nil)
        
    }
}

