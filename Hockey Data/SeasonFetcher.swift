//
//  SeasonFetcher.swift
//  Hockey Data
//
//  Created by Alex King on 9/27/17.
//  Copyright © 2017 Alex King. All rights reserved.
//

import Foundation
import Alamofire

struct SeasonFetcher {
    
    let username = "alexking124"
    let password = "vJk0Us5RsC"
    
    func fetchSeasons() {
        var headers: HTTPHeaders = [:]
        if let authorizationHeader = Request.authorizationHeader(user: username, password: password) {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        
        Alamofire.request("https://api.mysportsfeeds.com/v1.1/pull/nhl/2016-2017-regular/full_game_schedule.json", headers: headers)
            .response { response in
                print(response)
                print(response.response?.statusCode)
            }
            .responseJSON { json in
                print(json)
            }
    }
    
}
