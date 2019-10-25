//
//  AuthenticationService.swift
//  ArchitectureSample
//
//  Created by Catalina Turlea on 10/12/19.
//  Copyright © 2019 Catalina Turlea. All rights reserved.
//

import Foundation

protocol AuthenticationServiceProtocol {
    func login(email: String, password: String, completion: @escaping (NetworkError?) -> Void)
}

class AuthenticationService: AuthenticationServiceProtocol {
    private static var loginURL = URL(string: "https://my.app.com/login")!
    
    private let network: NetworkWrapperProtocol
    
    // Make dependencies explicit in the initializer
    init(network: NetworkWrapperProtocol = NetworkWrapper()) {
        self.network = network
    }
    
    /// Log the user in with email and password
    /// - Parameter email
    /// - Parameter password
    /// - Parameter completion: contains the result of the login and an optional error
    func login(email: String, password: String, completion: @escaping (NetworkError?) -> Void) {
        let params = ["email": email, "password": password]
        network.triggerRequest(url: AuthenticationService.loginURL,
                          method: .post,
                          parameters: params,
                          completion: { (response) in
            guard let error = response.error else {
                completion(nil)
                return
            }
            completion(error)
        })
    }
}
