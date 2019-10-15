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
        authenticationService = AuthenticationService(alamofire: alamofireMock)
    }
    
    func testSuccessfulLogin() {
        // Given
        let response = AlamofireResponse()
        alamofireMock.response = response
        
        // When
        let loginExpectation = expectation(description: "Should perfom login")
        var result: Bool?
        var loginError: Error?
        authenticationService.login(email: "myemail@codetalks.com", password: "somesafepassword") { (success, error) in
            result = success
            loginError = error
            loginExpectation.fulfill()
            
        }
        wait(for: [loginExpectation], timeout: 0.1)
        
        // Then
        XCTAssertNotNil(result, "Should return a successful result")
        XCTAssertTrue(result!, "Should return a successful result")
        XCTAssertNil(loginError, "Should not return any errors")
    }
    
    func testFailedLogin() {
        // Given
        let response = AlamofireResponse()
        response.error = AFError.invalidURL(url: URL(string: "someurl.com")!)
        alamofireMock.response = response
        
        // When
        let loginExpectation = expectation(description: "Should perfom login")
        var result: Bool?
        var loginError: Error?
        authenticationService.login(email: "myemail@codetalks.com", password: "somesafepassword") { (success, error) in
            result = success
            loginError = error
            loginExpectation.fulfill()
            
        }
        wait(for: [loginExpectation], timeout: 0.1)
        
        // Then
        XCTAssertNotNil(result, "Should not return a successful result")
        XCTAssertFalse(result!, "Should not return a successful result")
        XCTAssertNotNil(loginError, "Should return the error")
        
    }
}


class MockAlamofire: AlamofireWrapperProtocol {
    var response: AlamofireResponse?
    func request(url: URL, method: HTTPMethod, completion: @escaping (AlamofireResponse) -> Void) {
        request(url: url, method: method, parameters: nil, completion: completion)
    }
    
    func request(url: URL, method: HTTPMethod, parameters: Parameters?, completion: @escaping (AlamofireResponse) -> Void) {
        request(url: url, method: method, parameters: parameters, encoding:  URLEncoding.default, headers: [:], completion: completion)
    }
    
    func request(url: URL, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders, completion: @escaping (AlamofireResponse) -> Void) {
    
        completion(response ?? AlamofireResponse())
    }

}
