//
//  LoginViewController.swift
//  CustomLoginDemo
//
//  Created by ２１３ on 2020/7/6.
//  Copyright © 2020 ２１３. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        
        //Hide the error label
        errorLabel.alpha = 0
        
        //Style the elements
        //Utilities.styleTextField(emailTextField)
        //Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }
    
    //Check the field and validate that the data us correct. If everything is correct, this return nil. Otherwise, it returns the error message.
    func validateField()->String? {
        
        //Check that all fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill in all fields."
        }
        
        return nil
    }
    
    func showError(_ message:String){
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }

    @IBAction func loginTapped(_ sender: Any) {
        
        //Validate the fields
       let error = validateField()
       
       if error != nil {
           
           //There's something wrong with the fields, show error message
           showError(error!)
       }
       else {
                   
            //Create cleaned versions of the data
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create the user
            Auth.auth().signIn(withEmail: email, password: password) {(result,err) in
                
                if err != nil {
                    //Could't sign in
                    self.showError(err!.localizedDescription)
                    
                }else{
                    let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? UITabBarController
                    
                    self.view.window?.rootViewController = homeViewController
                    self.view.window?.makeKeyAndVisible()
                }
                
            }
        }
        
    }
}
