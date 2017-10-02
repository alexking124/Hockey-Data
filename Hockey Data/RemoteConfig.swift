//
//  RemoteConfig.swift
//  HockeyData
//
//  Created by Alex King on 10/1/17.
//  Copyright © 2017 Alex King. All rights reserved.
//

import FirebaseRemoteConfig

struct APIKey {
    let username: String
    let password: String
}

class FirebaseConfig {
    
    let remoteConfig = RemoteConfig.remoteConfig()
    var apiKey = APIKey(username: "", password: "")
    
    func fetch() {
        remoteConfig.fetch { [weak self] status, error in
            guard let strongSelf = self else { return }
            if status == .success {
                strongSelf.remoteConfig.activateFetched()
                guard
                    let username = strongSelf.remoteConfig.configValue(forKey: "api_key_username").stringValue,
                    !username.isEmpty,
                    let password = strongSelf.remoteConfig.configValue(forKey: "api_key_password").stringValue,
                    !password.isEmpty else {
                        return
                }
                strongSelf.apiKey = APIKey(username: username, password: password)
            }
        }
    }
}
