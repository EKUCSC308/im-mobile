//
//  ViewController.swift
//  IM-Mobile-Proj
//
//  Created by student on 4/12/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import UIKit
import SocketIO

class ViewController: UIViewController {
    
    @IBOutlet weak var newUserbtn: UIButton!
    
    @IBOutlet weak var loginbtn: UIButton!
    
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    let manager = SocketManager(socketURL: URL(string: "http://192.241.175.100:3002")!, config: [.log(true),.connectParams(["token": "....", "jwt": "..."])])
    var socket:SocketIOClient!
    
    @IBAction func logIn(_ sender: Any) {
        //check if they can log in or not
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
    }
    @IBAction func reg(_ sender: Any) {
        //check if they can log in or not
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
    }
    @IBAction func getconvo(_ sender: Any) {
        //check if they can log in or not
        let convoService = Conversations()
        
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
    }
    @IBAction func create(_ sender: Any) {
        //check if they can log in or not
        let convoService = Conversations()
        
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
        
        self.socket = manager.defaultSocket
        self.socket.on(clientEvent: .connect) {data, ack in
            print("socket connected");
        }
        
        self.socket.on("event") {data, ack in
            print("OCD Recieved");
        }
        
        self.socket.on(clientEvent: .disconnect) {data, ack in
            print("socket disconnected");
        }
        
        self.socket.connect()
        let user = Auth
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

