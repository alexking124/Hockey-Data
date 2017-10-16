//
//  Team.swift
//  Hockey Data
//
//  Created by Alex King on 9/27/17.
//Copyright © 2017 Alex King. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Team: Object, Mappable {
    
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    @objc dynamic var city: String?
    @objc dynamic var abbreviation: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["ID"]
        name <- map["Name"]
        city <- map["City"]
        abbreviation <- map["Abbreviation"]
    }
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
