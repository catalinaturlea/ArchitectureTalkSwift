//
//  DependencyInjection.swift
//  ArchitectureSample
//
//  Created by Catalina Turlea on 10/12/19.
//  Copyright © 2019 Catalina Turlea. All rights reserved.
//

import Foundation

class DependecyInjection {
    
    static let container = DependecyInjection()
    
    private(set) var userService: UserServiceProtocol!
    private(set) var network: NetworkWrapper!
    
    private init() {
        setupAllServices()
    }
    
    func setupAllServices() {
        // Start with the ones that have no dependencies
        
        // In our case, the networking framework
        network = NetworkWrapper()
        
        // Continue with the components dependent on what you have already initialised
        userService = UserService(network: network)
    }
    
}
