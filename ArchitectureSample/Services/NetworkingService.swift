//
//  NetworkingService.swift
//  ArchitectureSample
//
//  Created by Catalina Turlea on 10/15/19.
//  Copyright © 2019 Catalina Turlea. All rights reserved.
//

import Foundation

protocol NetworkingServiceProtocol {
    func hasInternetConnection() -> Bool
}

class NetworkingService: NetworkingServiceProtocol {
    
    func hasInternetConnection() -> Bool {
        return true
    }
}
