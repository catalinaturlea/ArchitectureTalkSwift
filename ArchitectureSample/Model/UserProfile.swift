//
//  File.swift
//  ArchitectureSample
//
//  Created by Catalina Turlea on 10/12/19.
//  Copyright © 2019 Catalina Turlea. All rights reserved.
//

import Foundation

struct UserProfile: Codable {
    let name: String
    let pictureURL: String?
    let age: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case pictureURL = "picture_url"
        case age = "age"
    }
}

// MARK: Convenience initializers
extension UserProfile {
    init?(data: Data) {
        let decoder = JSONDecoder()
        guard let me = try? decoder.decode(UserProfile.self, from: data) else {
            return nil
        }
        self = me
    }
}
