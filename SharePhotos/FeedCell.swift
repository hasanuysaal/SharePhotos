//
//  FeedCell.swift
//  SharePhotos
//
//  Created by Hasan Uysal on 8.09.2022.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var heartImageView: UIImageView!
    
    var docID = ""
    
    var timer = Timer()
    var counter = 1
    var likesCount = 0
    var userName = [String]()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellImageView.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedTheImage))
        gestureRecognizer.numberOfTapsRequired = 2
        cellImageView.addGestureRecognizer(gestureRecognizer)
        likesCountLabel.font = UIFont.boldSystemFont(ofSize: 16)
        heartImageView.image = UIImage(named: "heart")
        heartImageView.isHidden = true
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
        
    private func setTimer(){
        self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
    }
    
    @objc func timerFunc(){
        heartImageView.isHidden = false
        if self.counter == 0 {
            timer.invalidate()
            heartImageView.isHidden = true
        } else {
            self.counter -= 1
        }
        
    }
    
    @objc func tappedTheImage(){
        
        heartImageView.isHidden = false
        self.setTimer()
        
        let firestoreDB = Firestore.firestore()
        let likedPost =  firestoreDB.collection("Post").document(self.docID)
        likedPost.updateData(["whoLikes": FieldValue.arrayUnion([Auth.auth().currentUser?.email])])
        likedPost.updateData(["likesCount": String(self.likesCount)])
        likesCountLabel.text = "\(String(self.likesCount)) likes"
       
        
       
        
    }

}
