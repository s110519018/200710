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
    //alert
    @IBOutlet var myButton: UIButton!
    let customAlert = MyAlert()
    var event_count = 6

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
        //alert
        myButton.backgroundColor = .link
        myButton.setTitleColor(.white, for: .normal)
        myButton.setTitle("新增事件", for: .normal)
        
    }
    //alert自動跳出
    override func viewDidAppear(_ animated: Bool) {
        customAlert.showAlert_Q(with: "請問要新增事件嗎？",
        message: String(event_count),
        on: self)
        event_count-=1
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
    //alert按按鈕跳出
    @IBAction func didTapButton(){
        customAlert.showAlert_Q(with: "請問要新增事件嗎？",
        message: String(event_count),
        on: self)
        event_count-=1
    }
    @objc func dismissAlert(){
        customAlert.dismissAlert()
    }
}

//alerts，其他的swift檔案也可以呼叫
class MyAlert{
    struct Constants {
        static let backgroundAlphaTo: CGFloat = 0.6
    }
    //背景黑色
    private let backgroundView: UIView = {
       let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()
    //視窗
    private let alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 12
        return alert
        
    }()
    private var mytargetView: UIView?
    //新增事件視窗
    func showAlert_Q(with title: String,
                   message: String,
                   on ViewController: UIViewController){
        guard let targetView = ViewController.view else{
            return
        }
        
        mytargetView = targetView
        
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        targetView.addSubview(alertView)
        alertView.frame = CGRect(x: 40,
                                 y: -300,
                                 width: targetView.frame.size.width-80,
                                 height: 300)
        //標題
        let titleLabel = UILabel(frame: CGRect(x: 0,
                                               y: 0,
                                               width: alertView.frame.size.width,
                                               height: 80))
        titleLabel.text = title
        titleLabel.textAlignment = .center
        alertView.addSubview(titleLabel)
        //資訊 (還沒寫到數量用完時)
        let messageLabel = UILabel(frame: CGRect(x: 0,
                                                 y: 80,
                                                 width: alertView.frame.size.width,
                                                 height: 170))
            messageLabel.numberOfLines = 0
            messageLabel.text = "今日事件量"+message+"/6"
            messageLabel.textAlignment = .center
            alertView.addSubview(messageLabel)
        //關閉按鈕
        let button = UIButton(frame: CGRect(x: alertView.frame.size.width-(alertView.frame.size.width/2)-30,
                                            y: 0,
                                            width:alertView.frame.size.width,
                                            height: 50))
        button.setTitle("X", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(dismissAlert),
                         for: .touchUpInside)
        alertView.addSubview(button)
        //新增按鈕
        let add_event = UIButton(frame: CGRect(x: alertView.frame.size.width/8,
                                            y: alertView.frame.size.width-50,
                                            width:alertView.frame.size.width-70,
                                            height: 50))
        add_event.setTitle("新增", for: .normal)
        add_event.setTitleColor(.white, for: .normal)
        add_event.backgroundColor = UIColor(red: 56/255, green: 83/255, blue: 143/255, alpha: 1)
//        add_event.addTarget(self, action: #selector(dismissAlert),
//                         for: .touchUpInside)
        alertView.addSubview(add_event)
        UIView.animate(withDuration: 0.25,
                       animations: {
                        self.backgroundView.alpha = Constants.backgroundAlphaTo
        },completion: { done in
            if done{
                UIView.animate(withDuration: 0.25,animations: {
                    self.alertView.center = targetView.center
                })
            }
        })
    }
    //過往事件視窗
    func showeventAlert(with title: String,
                       message: String,
                       on ViewController: UIViewController){
            guard let targetView = ViewController.view else{
                return
            }
            
            mytargetView = targetView
            
            backgroundView.frame = targetView.bounds
            targetView.addSubview(backgroundView)
            targetView.addSubview(alertView)
            alertView.frame = CGRect(x: 40,
                                     y: -300,
                                     width: targetView.frame.size.width-80,
                                     height: 300)
            //標題
            let titleLabel = UILabel(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: alertView.frame.size.width,
                                                   height: 80))
            titleLabel.text = title
            titleLabel.textAlignment = .center
            alertView.addSubview(titleLabel)
            //資訊
            let messageLabel = UILabel(frame: CGRect(x: 0,
                                                   y: 80,
                                                   width: alertView.frame.size.width,
                                                   height: 170))
            messageLabel.numberOfLines = 0
            messageLabel.text = message
            messageLabel.textAlignment = .center
            alertView.addSubview(messageLabel)
            //關閉按鈕
            let button = UIButton(frame: CGRect(x: alertView.frame.size.width-(alertView.frame.size.width/2)-30,
                                                y: 0,
                                                width:alertView.frame.size.width,
                                                height: 50))
            button.setTitle("X", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.addTarget(self, action: #selector(dismissAlert),
                             for: .touchUpInside)
            alertView.addSubview(button)
            UIView.animate(withDuration: 0.25,
                           animations: {
                            self.backgroundView.alpha = Constants.backgroundAlphaTo
            },completion: { done in
                if done{
                    UIView.animate(withDuration: 0.25,animations: {
                        self.alertView.center = targetView.center
                    })
                }
            })
        }
    //關閉視窗動作
    @objc func dismissAlert() {
        guard let targetView = mytargetView else {
            return
        }
        UIView.animate(withDuration: 0.25,
                       animations: {
                        self.alertView.frame = CGRect(x: 40,
                                                      y: targetView.frame.size.height,
                                                      width: targetView.frame.size.width-80,
                                                      height: 300)
        },completion: { done in
            if done{
                UIView.animate(withDuration: 0.25,animations: {
                    self.backgroundView.alpha = 0
                }, completion: { done in
                    if done{
                        //完整清除一切subview
                        //https://blog.csdn.net/zhuiyi316/article/details/8308858
                        //https://www.itread01.com/articles/1484274841.html
                        for child : UIView in self.alertView.subviews as [UIView] {
                            child.removeFromSuperview()
                        }
                        self.alertView.removeFromSuperview()
                        self.backgroundView.removeFromSuperview()
                    }
                })
            }
        })
    }
}

