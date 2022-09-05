//
//  AlertMessagesController.swift
//  SharePhotos
//
//  Created by Hasan Uysal on 5.09.2022.
//

import Foundation
import UIKit.UIAlertController

class AlertCreator {
    
    func createAlert(title: String, msg: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertBtn = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(alertBtn)
    
        return alert
        
    }
    
}
