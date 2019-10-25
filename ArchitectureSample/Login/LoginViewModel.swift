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
    func login(email: String, password: String, completion: @escaping ((LoginViewModel.LoginError?) -> Void))
}

class LoginViewModel: LoginViewModelProtocol {
    
    /// Define all possible errors to be displayed
    enum LoginError {
        case emptyFields, invalidEmail, invalidCredentials, noInternet, generic
    }
    
    /// Explicit dependencies for the services
    let authenticationService: AuthenticationServiceProtocol
    let networkingService: NetworkingServiceProtocol
    
    /// Injecting the dependencies in the initliser
    init(authenticationService: AuthenticationServiceProtocol = AuthenticationService(),
         networkingService: NetworkingServiceProtocol = NetworkingService()) {
        self.authenticationService = authenticationService
        self.networkingService = networkingService
    }
    
    /// Login Method with all the validation previously done in the view controller
    /// - Parameter email
    /// - Parameter password
    /// - Parameter completion: will return the success status and an error result in case of failure
    func login(email: String, password: String, completion: @escaping ((LoginError?) -> Void)) {
        if email.isEmpty || password.isEmpty {
            completion(.emptyFields)
            return
        }
        if !isValidEmail(email) {
            completion(.invalidEmail)
            return
        }
        
        guard networkingService.hasInternetConnection() else {
            completion(.noInternet)
            return
        }
        
        authenticationService.login(email: email, password: password, completion: { ( error) in
            guard let error = error else {
                completion(nil)
                return
            }
            switch error.code {
            case 401:
                completion(.invalidCredentials)
            default:
                completion(.generic)
            }
        })
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[0-9a-z._%+-]+@[a-z0-9.-]+\\.[a-z]{2,64}"

        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email.lowercased())
    }
}
