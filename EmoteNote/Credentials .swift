//
//  Credentials .swift
//  EmoteNote
//
//  Created by William Leahy on 4/17/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import Foundation


class Constants {
    
    static let url : String =  "https://gateway.watsonplatform.net/natural-language-understanding/api"
    static let userID : String =  "5f99154c-2844-4d01-9b74-6dae23c112c5"
    static let passwordID : String = "NiodV5ClHxXU"
    static let versionDate : String = getCurrentDate(date: Date()) // use today's date for the most recent version (format "yyyy-mm-dd")
    
    
    class func getCurrentDate(date : Date) -> String {
        let date = date as NSDate
        let currentDateFormatter = DateFormatter()
        currentDateFormatter.dateFormat = "yyyy-MM-dd" // "dd MM yyyy"
        let stringDate = currentDateFormatter.string(from: date as Date)
        
        return stringDate
        
    }
}

