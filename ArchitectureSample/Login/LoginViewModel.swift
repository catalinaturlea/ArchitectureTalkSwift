//
//  LoginViewModel.swift
//  ArchitectureSample
//
//  Created by Catalina Turlea on 10/15/19.
//  Copyright © 2019 Catalina Turlea. All rights reserved.
//

import Foundation

/// Define the interface
protocol LoginViewModelProtocol {
    func login(email: String, password: String, completion: ((Bool, LoginViewModel.LoginError?) -> Void))
}

class LoginViewModel: LoginViewModelProtocol {
    
    /// Define all possible errors to be displayed
    enum LoginError {
        case emptyFields, invalidEmail, invalidCredentials, noInternet, generic
    }
    
    /// Explicit dependencies for the services
    let authenticationService: AuthenticationServiceProtocol
    
    /// Injecting the dependencies in the initliser
    init(authenticationService: AuthenticationServiceProtocol = AuthenticationService()) {
        self.authenticationService = authenticationService
        self.networkingService = networkingService
    }
    
    /// Login Method with all the validation previously done in the view controller
    /// - Parameter email
    /// - Parameter password
    /// - Parameter completion: will return the success status and an error result in case of failure
    func login(email: String, password: String, completion: ((Bool, LoginError?) -> Void)) {
        if email.isEmpty || password.isEmpty {
            completion(false, .emptyFields)
            return
        }
        if !isValidEmail(email) {
            completion(false, .invalidEmail)
            return
        }
        
        guard networkingService.hasInternet() else {
            completion(false, .noInternet)
            return
        }
        
        authenticationService.login(email: email, password: password, completion: { (success, error) in
            if success {
                completion(true, nil)
                return
            }
            switch error {
            case .invalidCredentials:
                completion(false, .invalidCredentials)
            default:
                completion(false, .generic)
            }
        })
    }
    
    func isValidEmail(_ email: String) -> Bool {
        return true
    }
}
