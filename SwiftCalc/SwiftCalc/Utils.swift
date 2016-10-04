//
//  Utils.swift
//  SwiftCalc
//
//  Created by Zach Zeleznick on 9/21/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import Foundation

// MARK:  Define any general utilities here

class Helper {
    // MARK: Sample Helper Class
    /*
     Helper.log10(100.0)
     >> Double = 2
     */
    class func log10(x: Double) -> Double {
        return log(x)/log(10.0)
    }
    
    // This converts someDataStructure to a whole string and return
    // ["1","3","5","5"] -> "1355"
    class func convertDataToString(data: [String]) -> String {
        var str = ""
        for n in data {
            str = str + n
        }
        return str
    }
    
    // This function checks if someDataStructure is an integer or a double
    class func isInteger(_ data: [String]) -> Bool {
        if data.contains(".") {
            return false
        }
        return true
    }
    
    class func convertStringToDataStructure(str: String) -> [String] {
        let dataStructure = str.characters.map {String($0)}
        return dataStructure
    }
    
    
}
