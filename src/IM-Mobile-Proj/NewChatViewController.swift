//
//  NewChatViewController.swift
//  IM-Mobile-Proj
//
//  Created by student on 4/30/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import UIKit

class NewChatViewController: UIViewController {

    @IBOutlet weak var chattokenfield: UITextField!
    @IBOutlet weak var joinbtn: UIButton!
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
        
        self.view.backgroundColor = bg_grey
        chattokenfield.backgroundColor = md_grey
        //password.backgroundColor = md_grey
        joinbtn.backgroundColor = gold_dark
        backbtn.backgroundColor = md_grey
        backbtn.setTitleColor(gold_lt, for: .normal)
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
