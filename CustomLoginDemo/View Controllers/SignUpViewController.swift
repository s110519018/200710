//
//  SignUpViewController.swift
//  CustomLoginDemo
//
//  Created by ２１３ on 2020/7/6.
//  Copyright © 2020 ２１３. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nickNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var passwordAgainTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
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
        //Utilities.styleTextField(firstNameTextField)
        //Utilities.styleTextField(lastNameTextField)
        //Utilities.styleTextField(emailTextField)
        //Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
    }

    //Check the field and validate that the data us correct. If everything is correct, this return nil. Otherwise, it returns the error message.
    func validateField()->String? {
        
        //Check that all fields are filled in
        if nickNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordAgainTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill in all fields."
        }
        
        //Check if the password is secure
        let cleanedPassedword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordAgain = passwordAgainTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassedword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }else if(cleanedPassedword.compare(passwordAgain).rawValue != 0){
            // PasswordAgain didn't equal to password
            return "Please make sure your password again is equal to password."
        }

        
        return nil
    }
    
    func showError(_ message:String){
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome(){
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? UITabBarController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }

    @IBAction func signUpTapped(_ sender: Any) {
        
        //Validate the fields
        let error = validateField()
        
        if error != nil {
            
            //There's something wrong with the fields, show error message
            showError(error!)
        }
        else {
            
            //Create cleaned versions of the data
            let nickName = nickNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create the user
            Auth.auth().createUser(withEmail: email, password: password){ (result, err) in
                
                //Check for errors
                if err != nil {
                    
                    //There was an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    
                    //User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").document(result!.user.uid).setData(["nickname":nickName,  "uid":result!.user.uid]){ (error) in
                        
                        if error != nil{
                            //show error message
                            self.showError("Error saving user data")
                        }
                        
                    }
                    
                    //Transition to the home screen
                    self.transitionToHome()
                }
                
            }
        }
       
    }
}
