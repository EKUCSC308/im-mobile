//
//  messageViewController.swift
//  IM-Mobile-Proj
//
//  Created by student on 4/26/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import UIKit
import SocketIO

struct ChatEvent: Decodable {
    var content: String,
    conversation_token: String,
    device_token: String,
    scope: String,
    type: String
}

class messageViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    var objmessages = [message]()
    var messages = [String]()
    var users = [String]()
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    //websocket manager
    let manager = SocketManager(socketURL: URL(string: "http://192.241.175.100:3002")!, config: [.log(true),.connectParams(["token": "....", "jwt": "..."])])
    var socket:SocketIOClient!
    
    //class to create the message type
    class message{
        var incoming = false // true= incoming | false = outgoing
        var content  = "Your head hits the wall." //default placeholder text
        var user  = "You're charged with death fuel." //default placeholder text
                    //The ecstacy's cruel.
    
        
        init(){
            incoming = false
            content = "Empty"
            user = "Nobody"
            }
        
        init(text: String){
            content = text
            incoming = false
            user = "Unknown"
            }
        
        init(text: String, userIn: String) {
            content = text
            incoming = true
            user = userIn
            }
        
        }
    
    override func viewDidLoad() {
        ////////////////////// Color Handling /////////////////////////
        
        let bg_grey = hex(hex: "#454547")
        
        let md_grey = hex(hex:  "#79797C");
        //let lt_grey = hex(hex:  "#E0E0E5");
        
        let gold_dk = hex(hex:  "#DDB606");
        //let gold_lt = hex(hex:  "#E5D089");
        
        //let red =     hex(hex:  "#BF5757");
        //let blue =    hex(hex:  "#54B6EA");
        //let green =   hex(hex:  "#4ABF6D");
        
        
        
        super.viewDidLoad()
        
        objmessages = [
            message(text:"outgoing"),
            message(text:"incoming", userIn:"Aaron"),
            message(text:"also outgoing")
        ]
        
        //creating and adding a label to the scrollView
        for i in 0..<objmessages.count {
            let label = UILabel()
            label.text = "   "+objmessages[i].content
            
            label.textColor = UIColor.white
            
            if( objmessages[i].incoming ){ //If the message was incoming
                label.backgroundColor = gold_dk
                label.frame = CGRect(x: 5, y: CGFloat(50*i), width: 150, height: 35)
                }
            else{       // If the message was outgoing
                label.backgroundColor = md_grey
                label.frame = CGRect(x: 220, y: CGFloat(45*i), width: 150, height: 35)

                }
            
            //adjusting the scrollView size for the message
            mainScrollView.contentSize.height += CGFloat(50)
            mainScrollView.addSubview(label)
            mainScrollView.backgroundColor = bg_grey
            }
        
        //adjusting the size of the scrollView for the textField
        mainScrollView.contentSize.height += CGFloat(50)
        
        //adding the textField and button backt to the bottom of the scrollView
        textField.frame = CGRect(x:0, y: CGFloat(mainScrollView.contentSize.height-50), width: 300, height: 35)
        
        sendButton.frame = CGRect(x:300, y:CGFloat(mainScrollView.contentSize.height-50), width: 50, height: 35)
        
        sendButton.backgroundColor = gold_dk
        
        mainScrollView.addSubview(textField)
        
        view.addSubview(mainScrollView)
        bottomScroll()
        
        self.socket = manager.defaultSocket
        
        // Execute when connection is established
        self.socket.on(clientEvent: .connect) {data, ack in
            print("SOCKET MANAGER: socket connected");
        }
        
        self.socket.on("event") {data, ack in
            if let arr = data as? [[String: Any]] {
                let eventResponse = ChatEvent(
                    content: arr[0]["content"]! as! String,
                    conversation_token: arr[0]["conversation_token"]! as! String,
                    device_token: arr[0]["device_token"]! as! String,
                    scope: arr[0]["scope"]! as! String,
                    type: arr[0]["type"]! as! String
                )
                
                self.handleChatEvent(event: eventResponse)
            }
        }
        
        
        // Executes when connection is inturrupted
        self.socket.on(clientEvent: .disconnect) {data, ack in
            print("SOCKET MANAGER: socket disconnected");
        }
        
        self.socket.connect()
    }
    
    
    //hitting the send button
    @IBAction func send(_ sender: Any) {
        view.endEditing(true)
        
        //DO NOT ALLOW USER TO SEND NULL MESSAGE
        // If the textfield is empty, disable the send button.
       // if self.textField.text == "" {
         //   self.sendButton.isEnabled = false}
        //else{ // if the textfield is occupied
        //    self.sendButton.isEnabled = true
        //}
        
        //getting the text from the text field
        let newText = textField.text!
        
        let temp = message(text: newText)
        temp.incoming = false
        
        if(newText != nil) {//If there is no text present, give empty string
            
            //send message obj to render fx
            renderMessage(msg: temp)
            //renderMessage(textmessage: newText!, isOwnMessage: true)
            textField.text = ""
            }
        
    }
    
    
    //rendering the message on the page
    func renderMessage(msg: message) {
        let label = UILabel()
        
        //label.text = textmessage
        label.text = "   "+msg.content
        
        /*
        label.frame = CGRect(x: 220, y: CGFloat(45*messages.count), width: 150, height: 35)
        mainScrollView.addSubview(label)
        messages.append(message)
        bottomScroll()
        */
        
        
        //Render Frame
        label.frame = CGRect(
            x: 220,
            y: CGFloat(50*(objmessages.count)),
            width: 150,
            height: 35
            )
        
        if( msg.incoming ){ //If the message was incoming
            label.backgroundColor = gold_dk
            label.frame = CGRect(x: 5, y: CGFloat(50*objmessages.count), width: 150, height: 35)
        }
        else{       // If the message was outgoing
            label.backgroundColor = md_grey
            label.frame = CGRect(x: 220, y: CGFloat(45*objmessages.count), width: 150, height: 35)
            
        }
        
        //label.backgroundColor = md_grey
        label.textColor = .white 
        
        //flag color
        //label.backgroundColor = red
        
        mainScrollView.contentSize.height += CGFloat(50)
        mainScrollView.addSubview(label)
        
        //messages.append(textmessage)
        
        //let temp = message(text: textmessage)
        
        objmessages.append(msg)
        
        bottomScroll()
        
        sendButton.frame = CGRect(x:300, y:CGFloat(mainScrollView.contentSize.height-50), width: 50, height: 35)
        
        textField.frame = CGRect(x:0, y: CGFloat(mainScrollView.contentSize.height-50), width: 300, height: 35)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    //if there is an event
    func handleChatEvent(event: ChatEvent) {
        if (event.scope == "session") {
            // render non-message on UI
        } else {
            // render message
           // renderMessage(textmessage: event.content, isOwnMessage: false)
            let temp = message(text: event.content)
            temp.incoming = true
            renderMessage(msg: temp)
        }
    }
    
    
    //disconnect from the websocket if it is closed
    override func viewWillDisappear(_ animated: Bool) {
        self.socket.disconnect()
    }
    
    
    //function to register the keyboard notifications
    func registerKeyboardNotifications() {
    //creating a notification for opening the keyboard
    NotificationCenter.default.addObserver(self,
                                               selector:#selector(keyboardWillShow(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
       
        //creating a notification for hiding the keyboard
    NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    //scroll to the bottom
    func bottomScroll(){
        //changing the offset to the bottom
        var offset = mainScrollView.contentOffset
        offset.y = mainScrollView.contentSize.height + mainScrollView.adjustedContentInset.bottom - mainScrollView.bounds.size.height
        mainScrollView.setContentOffset(offset, animated: true)
    }
    
    deinit { NotificationCenter.default.removeObserver(self)
    }
    
    //function if the keyboard is opened
    @objc func keyboardWillShow(notification: NSNotification) {
        //move the scrollView up
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        mainScrollView.contentInset = contentInsets
        mainScrollView.scrollIndicatorInsets = contentInsets
        
        //scroll the scrollView to the bottom (to show TextField)
        bottomScroll()
    }
    
    
    //function if the keyboard is closed
    @objc func keyboardWillHide(notification: NSNotification) {
        //resetting the scrollView to the whole page
        mainScrollView.contentInset = .zero
        mainScrollView.scrollIndicatorInsets = .zero
        
        bottomScroll()
    }
}
