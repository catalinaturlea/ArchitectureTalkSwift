//
//  LoginViewModelTests.swift
//  ArchitectureSampleTests
//
//  Created by Catalina Turlea on 16.10.19.
//  Copyright © 2019 Catalina Turlea. All rights reserved.
//

import Foundation

import XCTest
@testable import ArchitectureSample

class LoginViewModelTests: XCTestCase {
    
    var authenticationServiceMock = MockAuthenticationService()
    var networkServiceMock = MockNetworkingService()
    var loginViewModel: LoginViewModel!
    override func setUp() {
        loginViewModel = LoginViewModel(authenticationService: authenticationServiceMock, networkingService: networkServiceMock)
    }
    
    func testLoginWithEmptyEmail() {
        // Given
        let loginExpectation = expectation(description: "Should perfom login")
        var loginError: LoginViewModel.LoginError?
        
        // When
        loginViewModel.login(email: "", password: "password") { (error) in
            
            loginError = error
            loginExpectation.fulfill()
        }
        wait(for: [loginExpectation], timeout: 0.1)
        
        // Then
        XCTAssertNotNil(loginError, "There should be an error")
        XCTAssertEqual(loginError, LoginViewModel.LoginError.emptyFields, "error should be about the empty fields")
    }
    
    
    func testLoginWithEmptyPassword() {
        // Given
        let loginExpectation = expectation(description: "Should perfom login")
        var loginError: LoginViewModel.LoginError?
        
        // When
        loginViewModel.login(email: "email@test.com", password: "") { (error) in
            
            loginError = error
            loginExpectation.fulfill()
        }
        wait(for: [loginExpectation], timeout: 0.1)
        
        // Then
        XCTAssertNotNil(loginError, "There should be an error")
        XCTAssertEqual(loginError, LoginViewModel.LoginError.emptyFields, "error should be about the empty fields")
    }
    
    func testLoginWithEmptyEmailAndPassword() {
        // Given
        let loginExpectation = expectation(description: "Should perfom login")
        var loginError: LoginViewModel.LoginError?
        
        // When
        loginViewModel.login(email: "", password: "") { (error) in
            
            loginError = error
            loginExpectation.fulfill()
        }
        wait(for: [loginExpectation], timeout: 0.1)
        
        // Then
        XCTAssertNotNil(loginError, "There should be an error")
        XCTAssertEqual(loginError, LoginViewModel.LoginError.emptyFields, "error should be about the empty fields")
    }
    
    func testLoginWithInvalidEmail() {
        // Given
        let loginExpectation = expectation(description: "Should perfom login")
        var loginError: LoginViewModel.LoginError?
        
        // When
        loginViewModel.login(email: "test@c", password: "1234") { (error) in
            
            loginError = error
            loginExpectation.fulfill()
        }
        wait(for: [loginExpectation], timeout: 0.1)
        
        // Then
        XCTAssertNotNil(loginError, "There should be an error")
        XCTAssertEqual(loginError, LoginViewModel.LoginError.invalidEmail, "error should be about the empty fields")
    }
    
    func testLoginWithNoInternet() {
        // Given
        let loginExpectation = expectation(description: "Should perfom login")
        var loginError: LoginViewModel.LoginError?
        networkServiceMock.hasInternet = false
        
        // When
        loginViewModel.login(email: "my@email.com", password: "123") { (error) in
            
            loginError = error
            loginExpectation.fulfill()
        }
        wait(for: [loginExpectation], timeout: 0.1)
        
        // Then
        XCTAssertNotNil(loginError, "There should be an error")
        XCTAssertEqual(loginError, LoginViewModel.LoginError.noInternet, "error should be about the empty fields")
    }
    
    func testLoginWithInvalidCredential() {
        // Given
        authenticationServiceMock.loginError = NetworkError(error: nil, code: 401)
        let loginExpectation = expectation(description: "Should perfom login")
        var loginError: LoginViewModel.LoginError?
        networkServiceMock.hasInternet = true
        // When
        loginViewModel.login(email: "my@email.com", password: "123") { (error) in
            
            loginError = error
            loginExpectation.fulfill()
        }
        wait(for: [loginExpectation], timeout: 0.1)
        
        // Then
        XCTAssertNotNil(loginError, "There should be an error")
        XCTAssertEqual(loginError, LoginViewModel.LoginError.invalidCredentials, "error should be about the empty fields")
    }
    
    func testLoginWithGenericError() {
        // Given
        authenticationServiceMock.loginError = NetworkError(error: nil, code: 500)
        let loginExpectation = expectation(description: "Should perfom login")
        var loginError: LoginViewModel.LoginError?
        networkServiceMock.hasInternet = true
        
        // When
        loginViewModel.login(email: "my@email.com", password: "123") { (error) in
            loginError = error
            loginExpectation.fulfill()
        }
        wait(for: [loginExpectation], timeout: 0.1)
        
        // Then
        XCTAssertNotNil(loginError, "There should be an error")
        XCTAssertEqual(loginError, LoginViewModel.LoginError.generic, "error should be about the empty fields")
    }
    
    func testInvalidEmails() {
        // Given
        let invalidEmails = ["t@c.", "de@we.c", "de.cm"]
        
        // When
        for email in invalidEmails {
            let valid = loginViewModel.isValidEmail(email)
            // Then
            XCTAssertFalse(valid, "The email should be invalid")
        }
    }
    
    func testValidEmails() {
        // Given
        let invalidEmails = ["t@c.de", "de.dedded@we.com", "paul@de.cm"]
        
        // When
        for email in invalidEmails {
            let valid = loginViewModel.isValidEmail(email)
            // Then
            XCTAssertTrue(valid, "The email should be invalid")
        }
    }
}

class MockAuthenticationService: AuthenticationServiceProtocol {
    
    var loginError: NetworkError?
    
    func login(email: String, password: String, completion: @escaping (NetworkError?) -> Void) {
        completion(loginError)
    }
}

class MockNetworkingService: NetworkingServiceProtocol {
    
    var hasInternet = false
    
    func hasInternetConnection() -> Bool {
        return self.hasInternet
    }
}
