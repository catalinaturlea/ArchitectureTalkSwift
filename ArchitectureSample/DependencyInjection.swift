//
//  DependencyInjection.swift
//  ArchitectureSample
//
//  Created by Catalina Turlea on 10/12/19.
//  Copyright © 2019 Catalina Turlea. All rights reserved.
//

import Foundation

class DependecyInjection {
    
    private(set) var userService: UserServiceProtocol!
    private(set) var alamofire: AlamofireWrapper!
    
    init() {
        setupAllServices()
    }
    
    func setupAllServices() {
        // Start with the ones that have no dependencies
        
        // In our case, the networking framework
        alamofire = AlamofireWrapper()
        
        // Continue with the components dependent on what you have already initialised
        userService = UserService(alamofire: alamofire)
    }
    
}
