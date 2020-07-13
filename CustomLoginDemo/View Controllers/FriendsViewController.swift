//
//  FriendsViewController.swift
//  CustomLoginDemo
//
//  Created by ２１３ on 2020/7/13.
//  Copyright © 2020 ２１３. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class FriendsViewController: UIViewController {

    var friendsCurrentState = "no_friends"
    
    @IBOutlet weak var addFriendsButton: UIButton!
    
    @IBOutlet weak var friendIDTextFeild: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        
        errorLabel.alpha = 0
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElenemts()
    }
    
    func setUpElenemts() {
        
        Utilities.styleFilledButton(addFriendsButton)
    }
    
    @IBAction func addFriendsTapped(_ sender: Any) {
        
        let db = Firestore.firestore()
        
        let userID = Auth.auth().currentUser!.uid
        
        let friendID = friendIDTextFeild.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        db.collection("users").document(userID).collection("friends").document("requestFriend").setData([friendID: "1"], merge: true){ (error) in
            
            if error != nil{
                //show error message
                self.errorLabel.text = "Error adding friend"
                self.errorLabel.alpha = 1
            }else{
                self.errorLabel.text = "Success"
                self.errorLabel.alpha = 1
                db.collection("users").document(friendID).collection("friends").document("requestFriend").setData([userID: "0"], merge: true){ (error) in
            }
        }
    }
}
    
}
