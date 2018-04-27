//
//  ViewController.swift
//  IM-Mobile-Proj
//
//  Created by student on 4/12/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func logIn(_ sender: Any) {
        //check if they can log in or not
        
        /*
         let authService = Auth()
         
         let loginCallback: (_ response: LoginResponse?, _ error: String?) -> Void = { (response: LoginResponse?, error: String?) in
         if (error != nil) {
         print("Error while logging in.")
         } else {
         print("response found!")
         }
         }
         
         do {
         try authService.login(username: "test_username", password: "test_password", cb: loginCallback)
         } catch {
         print("An error was thrown")
         }

        */
    }
    
    @IBAction func newUser(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

