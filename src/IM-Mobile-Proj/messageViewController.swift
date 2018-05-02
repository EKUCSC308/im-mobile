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
    
    var messages = [String]()
    var users = [String]()
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    let manager = SocketManager(socketURL: URL(string: "http://192.241.175.100:3002")!, config: [.log(true),.connectParams(["token": "....", "jwt": "..."])])
    var socket:SocketIOClient!
    
    override func viewDidLoad() {
        
        ////////////////////// Color Handling /////////////////////////
        
        let bg_grey = hex(hex: "#454547")
        
        let md_grey = hex(hex:  "#79797C");
        let lt_grey = hex(hex:  "#E0E0E5");
        
        let gold_dk = hex(hex:  "#DDB606");
        let gold_lt = hex(hex:  "#E5D089");
        
        let red =     hex(hex:  "#BF5757");
        let blue =    hex(hex:  "#54B6EA");
        let green =   hex(hex:  "#4ABF6D");
        
        super.viewDidLoad()
        
        messages = ["Heyyy","Hi","hjof","message","what.","more","messages","so","what","why","ism't", "this","working"]
        
        for i in 0..<messages.count{
            let label = UILabel()
            label.text = messages[i]
            //let yPos = 50 * CGFloat(i)
            
            label.backgroundColor = .yellow
            label.frame = CGRect(x: 0, y: CGFloat(50*i), width: 150, height: 35)
            
            mainScrollView.contentSize.height += CGFloat(50)
            mainScrollView.addSubview(label)
        }
        
        mainScrollView.contentSize.height += CGFloat(50)
        
        textField.frame = CGRect(x:0, y: CGFloat(mainScrollView.contentSize.height-50), width: 300, height: 35)
        
        sendButton.frame = CGRect(x:300, y:CGFloat(mainScrollView.contentSize.height-50), width: 50, height: 35)
        
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
                print("test")
                
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
    
    @IBAction func send(_ sender: Any) {
        view.endEditing(true)
        let newText = textField.text
        if(newText != nil) {
            renderMessage(message: newText!, isOwnMessage: true)
            textField.text = ""
            
            // TODO >>>>>>>>>>>>>> emit to server (something like self.socket.emit('event, ChatEvent(...))
        }
    }
    
    func renderMessage(message: String, isOwnMessage: Bool) {
        let label = UILabel()
        label.text = message
        label.backgroundColor = .yellow
        
        print(50*messages.count)
        
        label.frame = CGRect(x: 0, y: CGFloat(50*(messages.count)), width: 150, height: 35)
        
        print(mainScrollView.contentSize.height)
        
        mainScrollView.contentSize.height = mainScrollView.contentSize.height + CGFloat(50)
        
        print(mainScrollView.contentSize.height)
        
        mainScrollView.addSubview(label)
        
        textField.frame = CGRect(x:0, y: CGFloat(mainScrollView.contentSize.height-50), width: 300, height: 35)
        
        sendButton.frame = CGRect(x:300, y:CGFloat(mainScrollView.contentSize.height-50), width: 50, height: 35)
        
        messages.append(message)
        bottomScroll()
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
    
    func handleChatEvent(event: ChatEvent) {
        if (event.scope == "session") {
            // render non-message on UI
        } else {
            // render message
            renderMessage(message: event.content, isOwnMessage: false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.socket.disconnect()
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(keyboardWillShow(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    //scroll to the bottom
    func bottomScroll(){
        var offset = mainScrollView.contentOffset
        offset.y = mainScrollView.contentSize.height + mainScrollView.adjustedContentInset.bottom - mainScrollView.bounds.size.height
        mainScrollView.setContentOffset(offset, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //function if the keyboard is opened
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        mainScrollView.contentInset = contentInsets
        mainScrollView.scrollIndicatorInsets = contentInsets
        
        bottomScroll()
    }
    
    
    //function if the keyboard is closed
    @objc func keyboardWillHide(notification: NSNotification) {
        mainScrollView.contentInset = .zero
        mainScrollView.scrollIndicatorInsets = .zero
        
        bottomScroll()
    }
}
