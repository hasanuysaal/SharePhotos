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
    var whoLikes = [String]()
    var docID : String
    var likesCount = "0"
    
    init(email: String, imageUrl: String, comment: String, whoLikes : [String], docID: String, likesCount: String){
       
        self.email = email
        self.imageUrl = imageUrl
        self.comment = comment
        self.whoLikes = whoLikes
        self.docID = docID
        self.likesCount = likesCount
    
    }
    
}
