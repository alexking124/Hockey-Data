//
//  Game.swift
//  Hockey Data
//
//  Created by Alex King on 9/27/17.
//Copyright © 2017 Alex King. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Game: Object, Mappable {
    
    dynamic var id: String?
    dynamic var date: String?
    dynamic var time: String?
    dynamic var location: String?
    dynamic var homeTeam: Team?
    dynamic var awayTeam: Team?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        date <- map["date"]
        time <- map["time"]
        location <- map["location"]
        homeTeam <- map["homeTeam"]
        awayTeam <- map["awayTeam"]
    }
    
    // Specify properties to ignore (Realm won't persist these)
    
    //  override static func ignoredProperties() -> [String] {
    //    return []
    //  }
}
