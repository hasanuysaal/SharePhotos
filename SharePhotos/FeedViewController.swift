//
//  FeedViewController.swift
//  SharePhotos
//
//  Created by Hasan Uysal on 5.09.2022.
//

import UIKit
import FirebaseFirestore
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var postArr = [Post]()
    var alertCreator = AlertCreator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        // Do any additional setup after loading the view.
        
        getDatasFromFS()
    }
    
    func getDatasFromFS(){
        
        let firestoreDB = Firestore.firestore()
        firestoreDB.collection("Post").order(by: "Date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil {
                
                let alert = self.alertCreator.createAlert(title: "Error", msg: error?.localizedDescription ?? "Datas cannot load")
                self.present(alert, animated: true, completion: nil )
                
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.postArr.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let docID = document.documentID
                        
                        if let imageUrl = document.get("imageUrl") as? String{
                            if let email = document.get("email") as? String {
                                if let comment = document.get("comment") as? String {
                                    if let whoLikes = document.get("whoLikes") as? [String] {
                                        if let likesCount = document.get("likesCount") as? String{
                                            let post = Post(email: email, imageUrl: imageUrl, comment: comment, whoLikes: whoLikes, docID: docID, likesCount: likesCount)
                                            self.postArr.append(post)
                                            
                                        }
                                            
                                    }
                                }
                            }
                        }
                        
                        
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArr.count
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        
        cell.userNameLabel.text = postArr[indexPath.row].email
        // using library to convert url-to-image (SDWebImage)
        cell.cellImageView.sd_setImage(with: URL(string: self.postArr[indexPath.row].imageUrl))
        cell.likesCountLabel.text = "\(String(postArr[indexPath.row].whoLikes.count)) likes"
        cell.docID = postArr[indexPath.row].docID
        cell.likesCount = postArr[indexPath.row].whoLikes.count
        let userName = postArr[indexPath.row].email.split(separator: "@")
        cell.commentLabel.text = "\(userName[0]): \(postArr[indexPath.row].comment)"
        
        return cell
    }

}
