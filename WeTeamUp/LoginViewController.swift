//
//  LoginViewController.swift
//  WeTeamUp
//
//  Created by Daniel Ayala on 17/07/2017.
//  Copyright © 2017 Daniel Ayala. All rights reserved.
//

import UIKit



class LoginViewController: UIViewController {
    
    
@IBOutlet weak var textFieldName: UITextField!

@IBOutlet weak var textFieldPass: UITextField!
    
@IBAction func buttonLoginAction(_ sender: Any) {
        
    if textFieldName.text == "admin" && textFieldPass.text == "admin"  {
            print("login is ok")
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "TeamHomeViewController") as! TeamHomeViewController
        myVC.stringLogin = textFieldName.text!
        navigationController?.pushViewController(myVC, animated: true)
       
        
        }else{
            print("login is NOT ok")

        }
    }
    
override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

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
