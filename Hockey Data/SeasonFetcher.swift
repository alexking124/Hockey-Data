//
//  SeasonFetcher.swift
//  Hockey Data
//
//  Created by Alex King on 9/27/17.
//  Copyright © 2017 Alex King. All rights reserved.
//

import RealmSwift
import Alamofire
import AlamofireObjectMapper

struct SeasonFetcher {
    
    let username = "alexking124"
    let password = "vJk0Us5RsC"
    
    func fetchSeason(_ season: Season, type: SeasonType = .regular, team: MSFTeamID? = nil) {
        var headers: HTTPHeaders = [:]
        guard let authorizationHeader = Request.authorizationHeader(user: username, password: password) else {
            return
        }
        headers[authorizationHeader.key] = authorizationHeader.value
        
        var query = ""
        if let team = team {
            query = "?team=\(team.rawValue)"
        }
        
        Alamofire.request("https://api.mysportsfeeds.com/v1.1/pull/nhl/\(season.requestString(type: type))/full_game_schedule.json\(query)", headers: headers)
            .responseArray(keyPath: "fullgameschedule.gameentry") { (response: DataResponse<[Game]>) in
                switch response.result {
                case .success(let games):
                    do {
                        let realm = try Realm()
                        try realm.write {
                            for game in games {
                                realm.add(game, update: true)
                            }
                        }
                        let sjsGames = realm.objects(Game.self).filter("homeTeam.abbreviation = 'SJS'")
                        print(sjsGames)
                    }
                    catch {
                        print(error)
                    }
                    
                case .failure(let error):
                    print(error)
                }
        }
    }
    
}
