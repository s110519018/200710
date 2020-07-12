//
//  HomeViewController.swift
//  CustomLoginDemo
//
//  Created by ２１３ on 2020/7/6.
//  Copyright © 2020 ２１３. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var nicknameText: UILabel!
    
    @IBOutlet weak var logOutButton: UIButton!
    
    func loadUserNickname(){
        
        let db = Firestore.firestore()
        
        let useID = Auth.auth().currentUser!.uid
        
        db.collection("users").document(useID).getDocument {(document,error) in
            
            if error == nil{
                
                if document != nil && document!.exists{
                    
                    self.nicknameText.text = document!.data()?["nickname"] as? String
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        loadUserNickname()
    }
    
    @IBAction func logOutTapped(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            
            let ViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.ViewController) as? UINavigationController
            
            self.view.window?.rootViewController = ViewController
            self.view.window?.makeKeyAndVisible()
            
        }catch{
            print(error)
        }
    }
    
}
