//
//  SigninViewController.swift
//  InstaAppli
//
//  Created by 倉田　隆成 on 2018/05/28.
//  Copyright © 2018年 倉田　隆成. All rights reserved.
//

import UIKit
import NCMB

class SigninViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var userTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userTextField.delegate = self
        passwordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func signIn() {
        if (userTextField.text?.characters.count)! > 0 && (passwordTextField.text?.characters.count)! > 0{
            NCMBUser.logInWithUsername(inBackground: userTextField.text!, password: passwordTextField.text!) { (user, error) in
                if error != nil{
                    print("error")
                }else {
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    
                    //ログイン状態の保持
                    let ud = UserDefaults.standard
                    ud.set(true, forKey: "isLogin")
                    ud.synchronize()
                }
            }
        }
    }
    
    @IBAction func forget() {
        
    }

}
