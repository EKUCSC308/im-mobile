//
//  messageViewController.swift
//  IM-Mobile-Proj
//
//  Created by student on 4/26/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import UIKit

class messageViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    var messages = ["Hi","Heeeeyyyyyyy", "What up?", "Nothing", "Come over?", "Nahhhh", "Why?", "H8 u"]
    
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
        var thisy = 0;
        for m in messages{
            var dynamicLabel: UILabel = UILabel()
            dynamicLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 21)
            dynamicLabel.textColor = lt_grey
            //dynamicLabel.center = CGPoint(x: 160, y: thisy)
            dynamicLabel.backgroundColor = bg_grey
            dynamicLabel.textAlignment = .center
            dynamicLabel.text = m
        //self.view.addSubview(dynamicLabel)
            stackView.addArrangedSubview(dynamicLabel)
            thisy += 22
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
