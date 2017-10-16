//
//  Season.swift
//  HockeyData
//
//  Created by Alex King on 10/15/17.
//  Copyright © 2017 Alex King. All rights reserved.
//

import Foundation

enum SeasonType: String {
    case regular
    case playoffs
}

enum Season: String {
    case s16_17 = "2016-2017"
    case s15_16 = "2015-2016"
    case s14_15 = "2014-2015"
    case s13_14 = "2013-2014"
    
    func requestString(type: SeasonType) -> String {
        return "\(rawValue)-\(type)"
    }
    
    static var allValues: [Season] {
        return [.s16_17, .s15_16, .s14_15, .s13_14]
    }
}
