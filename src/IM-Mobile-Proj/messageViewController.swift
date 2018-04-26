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
        super.viewDidLoad()
        var thisy = 0;
        for m in messages{
            var dynamicLabel: UILabel = UILabel()
            dynamicLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 21)
            dynamicLabel.textColor = .black
            //dynamicLabel.center = CGPoint(x: 160, y: thisy)
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
