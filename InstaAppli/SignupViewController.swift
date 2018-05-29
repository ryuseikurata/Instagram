//
//  SignupViewController.swift
//  InstaAppli
//
//  Created by 倉田　隆成 on 2018/05/28.
//  Copyright © 2018年 倉田　隆成. All rights reserved.
//

import UIKit
import NCMB

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var userTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        userTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func signUp() {
        let user = NCMBUser()
        
        if (userTextField.text?.characters.count)! < 4{
            user.password = passwordTextField.text!
        }
        user.userName = userTextField.text!
        user.mailAddress = emailTextField.text!
        
        if passwordTextField.text == confirmTextField.text {
            user.password = passwordTextField.text!
        } else {
            print("パスワードの不一致")
        }
        
        user.signUpInBackground { (error) in
            if error != nil{
                //エラーがあった場合
                print("error")
            } else {
                //登録成功
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
