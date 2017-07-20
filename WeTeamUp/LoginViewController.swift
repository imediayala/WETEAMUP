//
//  LoginViewController.swift
//  WeTeamUp
//
//  Created by Daniel Ayala on 17/07/2017.
//  Copyright © 2017 Daniel Ayala. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore
import FacebookLogin
import FBSDKLoginKit
import FBSDKCoreKit




class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    // THIS IS HOW PROPERTIES ARE DECLARED
    
    @IBOutlet weak var textFieldName: UITextField!
    
    @IBOutlet weak var textFieldPass: UITextField!
    
    let loginButton = FBSDKLoginButton()
    
    
    @IBAction func buttonLoginAction(_ sender: Any) {
        
        //PUSH VIEW CONTROLLER AND SEND OBJECT
        
        //        let myVC = storyboard?.instantiateViewController(withIdentifier: "TeamHomeViewController") as! TeamHomeViewController
        //        myVC.stringLogin = textFieldName.text!
        //        navigationController?.pushViewController(myVC, animated: true)
        
        
        if textFieldName.text == "admin" && textFieldPass.text == "admin"  {
            print("login is ok")
            
            //PERFORM SEGUE IN SWIFT IS COOL
            
            performSegue(withIdentifier: "goHome", sender: nil)
            
        }else{
            print("login is NOT ok")
            
        }
    }
    
    override func viewDidLoad() {
        
        if FBSDKAccessToken.current() != nil {
            // user already has access token
        } else {
            
            loginButton.readPermissions = ["public_profile","email","user_friends","user_hometown"]
            loginButton.center = self.view.center
            self.loginButton.delegate = self as FBSDKLoginButtonDelegate
            self.view.addSubview(loginButton)
            
        }
    }
    
    // Facebook Delegate Methods
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
                
                performSegue(withIdentifier: "goHome", sender: nil)
                
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    //    // Once the button is clicked, show the login dialog
    //    @objc func loginButtonClicked() {
    //        let loginManager = LoginManager()
    //        loginManager.logIn([ .PublicProfile ], viewController: self) { loginResult in
    //            switch loginResult {
    //            case .Failed(let error):
    //                print(error)
    //            case .Cancelled:
    //                print("User cancelled login.")
    //            case .Success(let grantedPermissions, let declinedPermissions, let accessToken):
    //                print("Logged in!")
    //            }
    //        }
    //
    //    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
