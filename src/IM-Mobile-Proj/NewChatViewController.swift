//
//  NewChatViewController.swift
//  IM-Mobile-Proj
//
//  Created by student on 4/30/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import UIKit

class NewChatViewController: UIViewController {
    //outlets
    @IBOutlet weak var chattokenfield: UITextField!
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
        
        //setting the colors
        self.view.backgroundColor = bg_grey
        chattokenfield.backgroundColor = md_grey
        //password.backgroundColor = md_grey
        //joinbtn.backgroundColor = gold_dark
        backbtn.backgroundColor = md_grey
        backbtn.setTitleColor(gold_lt, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //allowing the user to create a chat
    @IBAction func createChat(_ sender: Any) {
        let chatService = ConversationService()
        
        let chatCallback: (_ response: Conversation?, _ error: String?) -> Void = { (response: Conversation?, error: String?) in
            if (error != nil) { //if there is an error in the chat
                
                //create an alert to show the error
                let alertController = UIAlertController(title: "Error creating chat",
                                                        message: "You could not create chat because: \(error)!",
                    preferredStyle: UIAlertControllerStyle.alert)
                
                let defaultAction = UIAlertAction(title: "OK",
                                                  style: UIAlertActionStyle.cancel,
                                                  handler: nil)
                
                alertController.addAction(defaultAction)                    // add action button into the alert window
                
                self.present(alertController, animated: true, completion: nil)
                
                
            } else {
                print("SERVICE: Create chat successful")
                self.performSegue(withIdentifier: "toChat", sender: nil)
            }
        }
        
        do {
            try chatService.createConvo(label: chattokenfield.text!, cb: chatCallback)
        } catch {
            print("An error was thrown")
        }
    }
}
