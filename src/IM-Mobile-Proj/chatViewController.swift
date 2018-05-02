//
//  chatViewController.swift
//  IM-Mobile-Proj
//
//  Created by student on 4/26/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import UIKit

class chatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var logoutbtn: UIButton!
    //@IBOutlet weak var protolabel: UILabel!
    
    var chats = ["Chat 1", "Chat 2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14","15","16"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        
        table.backgroundColor = bg_grey
        table.separatorColor = md_grey
        
        
       // protolabel.backgroundColor = bg_grey
        //protolabel.textColor = lt_grey
        
        logoutbtn.setTitleColor(red, for: .normal)
        
        //code to populate chat array
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        UserDefaults.standard.removeObject(forKey: "jwt")
        self.performSegue(withIdentifier: "logOut", sender: nil)
    }
    

    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    }
    
    //number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //number title of section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    //number of rows in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    //adding a title to each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell") as? chatTableViewCell
        
        cell?.label.text = chats[indexPath.row]
        cell?.label.backgroundColor = bg_grey
        cell?.label.textColor = lt_grey
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "thisOne", sender: self)
    }
}
