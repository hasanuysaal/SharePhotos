//
//  Post.swift
//  SharePhotos
//
//  Created by Hasan Uysal on 8.09.2022.
//

import Foundation

class Post {
    
    var email : String
    var imageUrl : String
    var comment : String
    
    init(email: String, imageUrl: String, comment: String){
        
        self.email = email
        self.imageUrl = imageUrl
        self.comment = comment
        
    }
    
}
