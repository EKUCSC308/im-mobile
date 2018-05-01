//
//  messageViewController.swift
//  IM-Mobile-Proj
//
//  Created by student on 4/26/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import UIKit

class messageViewController: UIViewController {
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    var messages = [String]()
    
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
        //mainScrollView.frame = view.frame
        messages = ["Heyyy","Hi","hjof","message","what.","more","messages","so","what","why","ism't", "this","working"]
        
        for i in 0..<messages.count{
            let label = UILabel()
            label.text = messages[i]
            print(label.text)
            //let yPos = 50 * CGFloat(i)
            label.backgroundColor = .yellow
            label.frame = CGRect(x: 0, y: CGFloat(50*i), width: 150, height: 35)
            
            mainScrollView.contentSize.height = mainScrollView.contentSize.height + CGFloat(50)
            print(mainScrollView.contentSize.height)
            mainScrollView.addSubview(label)
            //view.addSubview(mainScrollView)
            
        }
        view.addSubview(mainScrollView)
    }
    
    @IBAction func doneTexting(_ sender: Any) {
        
    }
    
    
    @IBAction func endEditing(_ sender: Any) {
        view.endEditing(true)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        mainScrollView.contentInset = contentInsets
        mainScrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        mainScrollView.contentInset = .zero
        mainScrollView.scrollIndicatorInsets = .zero
    }
}
