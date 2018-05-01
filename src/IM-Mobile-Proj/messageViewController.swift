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
            label.frame = CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100+CGFloat(50*i), width: 150, height: 35)
            
            mainScrollView.contentSize.height = mainScrollView.contentSize.height + CGFloat(50)
            print(mainScrollView.contentSize.height)
            mainScrollView.addSubview(label)
            
            var cnt = 0
            for subView in mainScrollView.subviews{
                // Here You can Get all subViews of your myScrollView.
                // But For Check subview is specific UIClass such like label, button, textFiled etc.. write following code (here checking for example UILabel class).
                
                if subView is (UILabel) { // Check is SubView Class Is UILabel class?
                    print(cnt)
                    cnt = cnt+1
                }
            }
            view.addSubview(mainScrollView)
            for i in view.subviews{
                print(i)
            }
            
        }
        //self.view.addSubview(mainScrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        mainScrollView.contentSize = CGSize(width: 375, height: 800)
    }
}
