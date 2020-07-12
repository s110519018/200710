//
//  BottleViewController.swift
//  CustomLoginDemo
//
//  Created by ２１３ on 2020/7/8.
//  Copyright © 2020 ２１３. All rights reserved.
//

import UIKit

class BottleViewController: UIViewController {

    @IBOutlet weak var CalendarContainerView: UIView!
    
    @IBOutlet weak var AnalysisContainerView: UIView!
    
    @IBOutlet weak var BottleSegementItem: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BottleSegementItem.selectedSegmentIndex = 0
        
        CalendarContainerView.isHidden = false
        
        AnalysisContainerView.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func SegmentChange(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
            CalendarContainerView.isHidden = false
            
            AnalysisContainerView.isHidden = true
        }else{
            CalendarContainerView.isHidden = true
            
            AnalysisContainerView.isHidden = false
        }
    }
}
