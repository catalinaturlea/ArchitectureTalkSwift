//
//  AuthenticationService.swift
//  ArchitectureSample
//
//  Created by Catalina Turlea on 10/12/19.
//  Copyright © 2019 Catalina Turlea. All rights reserved.
//

import Foundation

protocol AuthenticationServiceProtocol {
    func login(email: String, password: String, completion: @escaping (Bool, Error?) -> Void)
}

class AuthenticationService {
    private static var loginURL = URL(string: "https://my.app.com/login")!
    
    let alamofire: AlamofireWrapperProtocol
    
    // Make dependencies explicit in the initiliazer
    init(alamofire: AlamofireWrapperProtocol) {
        self.alamofire = alamofire
    }
    
    func login(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let params = ["email": email, "password": password]
        alamofire.request(url: AuthenticationService.loginURL,
                          method: .post,
                          parameters: params,
                          completion: { (response) in
            guard let error = response.error else {
                completion(true, nil)
                return
            }
            
            completion(false, error)
        })
    }
}
