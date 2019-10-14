//
//  UserService.swift
//  ArchitectureSample
//
//  Created by Catalina Turlea on 10/12/19.
//  Copyright © 2019 Catalina Turlea. All rights reserved.
//

import Foundation
import Alamofire

protocol UserServiceProtocol {
    func fetchUserProfile(completion: @escaping (UserProfile?, Error?) -> Void)
}

class UserService: UserServiceProtocol {
    private static var userProfileUrl = URL(string: "https://my.app.com/profile")!
    
    let alamofire: AlamofireWrapper
    
    init(alamofire: AlamofireWrapper) {
        self.alamofire = alamofire
    }
    
    func fetchUserProfile(completion: @escaping (UserProfile?, Error?) -> Void) {
        alamofire.request(url: UserService.userProfileUrl, method: .get, completion: { (response) in
            guard let data = response.data else {
                completion(nil, response.error)
                return
            }
            guard let profile = UserProfile(data: data) else {
                completion(nil, response.error)
                return
            }
            
            completion(profile, nil)
        })
    }
}
