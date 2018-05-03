//
//  NewUserViewController.swift
//  IM-Mobile-Proj
//
//  Created by student on 4/30/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import UIKit

class NewUserViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var regbutn: UIButton!
    
    @IBOutlet weak var backbtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ////////////////////// Color Handling /////////////////////////
        
        let bg_grey = hex(hex: "#454547")
        
        let md_grey = hex(hex:  "#79797C");
        let lt_grey = hex(hex:  "#E0E0E5");
        
        let gold_dark = hex(hex:  "#DDB606");
        let gold_lt = hex(hex:  "#E5D089");
        
        let red =     hex(hex:  "#BF5757");
        let blue =    hex(hex:  "#54B6EA");
        let green =   hex(hex:  "#4ABF6D");
        
        //setting the background colors
        self.view.backgroundColor = bg_grey
        username.backgroundColor = md_grey
        password.backgroundColor = md_grey
        regbutn.backgroundColor = gold_dark
        backbtn.backgroundColor = md_grey
        backbtn.setTitleColor(gold_lt, for: .normal)
        
        // Do any additional setup after loading the view.
    }
    
    //function to deal with the colors
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //function to register the account
    @IBAction func registerAccount(_ sender: Any) {
        let authService = AuthService()
        
        let registrationCallback: (_ response: RegisterResponse?, _ error: String?) -> Void = { (response: RegisterResponse?, error: String?) in
            if (error != nil) { //if there was an error in registering
                
                //create an alert with the error
                let alertController = UIAlertController(title: "Error create user in",
                                                        message: "You could not create user because: \(error)!",
                    preferredStyle: UIAlertControllerStyle.alert)
                
                let defaultAction = UIAlertAction(title: "OK",
                                                  style: UIAlertActionStyle.cancel,
                                                  handler: nil)
                
                alertController.addAction(defaultAction)                    // add action button into the alert window
                
                self.present(alertController, animated: true, completion: nil)
                print("SERVICE: registration request failed")
            } else {
                print("SERVICE: registration response")
            }
        }
        
        do {
            try authService.register(username: username.text!, password: password.text!, cb: registrationCallback)
            self.performSegue(withIdentifier: "backToLogin", sender: nil)
        } catch {
            print("An error was thrown")
        }
    }
}
