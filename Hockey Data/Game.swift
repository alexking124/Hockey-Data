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
    
    static let dateFormatter = DateFormatter(withFormat: "yyyy-MM-dd", locale: "en_US")
    
    dynamic var id: String?
    dynamic var date: Date?
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
        date <- (map["date"], DateFormatterTransform(dateFormatter: Game.dateFormatter))
        time <- map["time"]
        location <- map["location"]
        homeTeam <- map["homeTeam"]
        awayTeam <- map["awayTeam"]
    }
    
}
