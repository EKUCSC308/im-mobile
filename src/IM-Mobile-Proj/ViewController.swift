//
//  ViewController.swift
//  IM-Mobile-Proj
//
//  Created by student on 4/12/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var newUserbtn: UIButton!
    
    @IBOutlet weak var loginbtn: UIButton!
    
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func logIn(_ sender: Any) {
         let authService = AuthService()
         
         let loginCallback: (_ response: LoginResponse?, _ error: String?) -> Void = { (response: LoginResponse?, error: String?) in
            if (error != nil) {
                
                let alertController = UIAlertController(title: "Error logging in",
                                                        message: "You could not log in because: \(error)!",
                                                        preferredStyle: UIAlertControllerStyle.alert)
                
                let defaultAction = UIAlertAction(title: "OK",
                                                  style: UIAlertActionStyle.cancel,
                                                  handler: nil)
                
                alertController.addAction(defaultAction)                    // add action button into the alert window
                
                self.present(alertController, animated: true, completion: nil)
                
                
             } else {
                print("SERVICE: login successful")
                let defaults = UserDefaults.standard
                defaults.set(response!.jwt, forKey: "jwt")
                self.performSegue(withIdentifier: "loginToConversations", sender: nil)
             }
         }
         
         do {
            try authService.login(username: usernameText.text!, password: passwordText.text!, cb: loginCallback)
         } catch {
            print("An error was thrown")
        }
    }
    
    @IBAction func newUser(_ sender: Any) {
        
    }
    
    func hex (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        ////////////////////// Color Handling /////////////////////////
        
        let bg_grey = hex(hex: "#454547")
        
        let md_grey = hex(hex:  "#79797C");
        let lt_grey = hex(hex:  "#E0E0E5");
        
        let gold_dk = hex(hex:  "#DDB606");
        let gold_lt = hex(hex:  "#E5D089");
        
        let red =     hex(hex:  "#BF5757");
        let blue =    hex(hex:  "#54B6EA");
        let green =   hex(hex:  "#4ABF6D");
        
        self.view.backgroundColor = bg_grey
        usernameText.backgroundColor = md_grey
        passwordText.backgroundColor = md_grey
        loginbtn.backgroundColor = gold_dk
        newUserbtn.backgroundColor = gold_lt
        
        openChatsIfLoggedIn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        openChatsIfLoggedIn()
    }

    func openChatsIfLoggedIn() {
        let defaults = UserDefaults.standard
        let jwt = defaults.string(forKey: "jwt")
        
        if (jwt != nil) {
            performSegue(withIdentifier: "loginToConversations", sender: nil)
        }
    }
}

