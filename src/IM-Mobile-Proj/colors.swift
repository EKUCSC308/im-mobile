//
//  colors.swift
//  IM-Mobile-Proj
//
//  Created by student on 4/26/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import Foundation;
import UIKit;

//public class colorSheet: NSObject{

public func hex (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

public let bg_grey = hex(hex: "#454547")

public let md_grey = hex(hex:  "#79797C");
public let lt_grey = hex(hex:  "#E0E0E5");

public let gold_dk = hex(hex:  "#DDB606");
public let gold_lt = hex(hex:  "#E5D089");

public let red =     hex(hex:  "#BF5757");
public let blue =    hex(hex:  "#54B6EA");
public let green =   hex(hex:  "#4ABF6D");
    
//}
