//
//  AuthenticationServiceTests.swift
//  ArchitectureSampleTests
//
//  Created by Catalina Turlea on 10/13/19.
//  Copyright © 2019 Catalina Turlea. All rights reserved.
//

import Alamofire
import XCTest
@testable import ArchitectureSample

class AuthenticationServiceTests: XCTestCase {
    
    var authenticationService: AuthenticationService!
    var alamofireMock = MockAlamofire()
    
    override func setUp() {
        authenticationService = AuthenticationService(network: alamofireMock)
    }
    
    func testSuccessfulLogin() {
        // Given
        let response = NetworkResponse()
        alamofireMock.response = response
        
        // When
        let loginExpectation = expectation(description: "Should perfom login")
        var loginError: NetworkError?
        authenticationService.login(email: "myemail@codetalks.com", password: "somesafepassword") { (error) in
            loginError = error
            loginExpectation.fulfill()
            
        }
        wait(for: [loginExpectation], timeout: 0.1)
        
        // Then
        XCTAssertNil(loginError, "Should not return any errors")
    }
    
    func testFailedLogin() {
        // Given
        let response = NetworkResponse()
        response.error = NetworkError(error: nil, code: 401)
        alamofireMock.response = response
        
        // When
        let loginExpectation = expectation(description: "Should perfom login")
        var loginError: NetworkError?
        authenticationService.login(email: "myemail@codetalks.com", password: "somesafepassword") { (error) in
            loginError = error
            loginExpectation.fulfill()
            
        }
        wait(for: [loginExpectation], timeout: 0.1)
        
        // Then
        XCTAssertNotNil(loginError, "Should return the error")
    }
    
    func testLoginWithCorrectCredentials() {
        // Given
        let response = NetworkResponse()
        alamofireMock.response = response
        let email = "myemail@codetalks.com"
        let password = "somesafepassword"
        
        // When
        let loginExpectation = expectation(description: "Should perfom login")
        var loginError: NetworkError?
        authenticationService.login(email: email, password: password) { (error) in
            loginError = error
            loginExpectation.fulfill()
            
        }
        wait(for: [loginExpectation], timeout: 0.1)
        
        // Then
        XCTAssertNil(loginError, "Should return the error")
        XCTAssertEqual(alamofireMock.parameters?["email"] as! String, email)
        XCTAssertEqual(alamofireMock.parameters?["password"] as! String, password)
    }
}


class MockAlamofire: NetworkWrapperProtocol {
    var response: NetworkResponse?
    var parameters: [String: Any]?
    
    func triggerRequest(url: URL, method: HTTPMethod, completion: @escaping (NetworkResponse) -> Void) {
        triggerRequest(url: url, method: method, parameters: nil, completion: completion)
    }
    
    func triggerRequest(url: URL, method: HTTPMethod, parameters: Parameters?, completion: @escaping (NetworkResponse) -> Void) {
        triggerRequest(url: url, method: method, parameters: parameters, encoding:  URLEncoding.default, headers: [:], completion: completion)
    }
    
    func triggerRequest(url: URL,
                 method: HTTPMethod,
                 parameters: Parameters?,
                 encoding: ParameterEncoding,
                 headers: HTTPHeaders,
                 completion: @escaping (NetworkResponse) -> Void) {
        
        self.parameters = parameters
        completion(response ?? NetworkResponse())
    }
    
}
