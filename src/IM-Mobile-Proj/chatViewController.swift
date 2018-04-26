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
    
    var chats = ["Chat 1", "Chat 2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14","15","16"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //code to populate chat array
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
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "thisOne", sender: self)
    }
}
