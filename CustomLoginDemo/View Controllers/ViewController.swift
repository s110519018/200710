//
//  ViewController.swift
//  CustomLoginDemo
//
//  Created by ２１３ on 2020/7/6.
//  Copyright © 2020 ２１３. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpElenemts()
    }

    func setUpElenemts() {
        
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleFilledButton(loginButton)
    }

}

