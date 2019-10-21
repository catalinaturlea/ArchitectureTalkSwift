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

    func testV() {
        let vc = LoginViewController()
        vc.viewModel = MockViewModel()

        vc.login(email: "wee", password: "asd")

        

    }

    func testLoginWithEmptyEmail() {
        // Given
        let loginExpectation = expectation(description: "Should perfom login")
        var loginResult: Bool?
        var loginError: LoginViewModel.LoginError?

        // When
        loginViewModel.login(email: "", password: "password") { (result, error) in
            loginResult = result
            loginError = error
            loginExpectation.fulfill()
        }
        wait(for: [loginExpectation], timeout: 0.1)

        // Then
        XCTAssertFalse(loginResult!, "Login should fail")
        XCTAssertNotNil(loginError, "There should be an error")
        XCTAssertEqual(loginError, LoginViewModel.LoginError.emptyFields, "error should be about the empty fields")
    }


    func testLoginWithEmptyPassword() {
        // Given
        let loginExpectation = expectation(description: "Should perfom login")
        var loginResult: Bool?
        var loginError: LoginViewModel.LoginError?

        // When
        loginViewModel.login(email: "email@test.com", password: "") { (result, error) in
            loginResult = result
            loginError = error
            loginExpectation.fulfill()
        }
        wait(for: [loginExpectation], timeout: 0.1)

        // Then
        XCTAssertFalse(loginResult!, "Login should fail")
        XCTAssertNotNil(loginError, "There should be an error")
        XCTAssertEqual(loginError, LoginViewModel.LoginError.emptyFields, "error should be about the empty fields")
    }

    func testLoginWithEmptyEmailAndPassword() {
        // Given
        let loginExpectation = expectation(description: "Should perfom login")
        var loginResult: Bool?
        var loginError: LoginViewModel.LoginError?

        // When
        loginViewModel.login(email: "", password: "") { (result, error) in
            loginResult = result
            loginError = error
            loginExpectation.fulfill()
        }
        wait(for: [loginExpectation], timeout: 0.1)

        // Then
        XCTAssertFalse(loginResult!, "Login should fail")
        XCTAssertNotNil(loginError, "There should be an error")
        XCTAssertEqual(loginError, LoginViewModel.LoginError.emptyFields, "error should be about the empty fields")
    }

    func testLoginWithInvalidEmail() {
        // Given
        let loginExpectation = expectation(description: "Should perfom login")
        var loginResult: Bool?
        var loginError: LoginViewModel.LoginError?

        // When
        loginViewModel.login(email: "", password: "") { (result, error) in
            loginResult = result
            loginError = error
            loginExpectation.fulfill()
        }
        wait(for: [loginExpectation], timeout: 0.1)

        // Then
        XCTAssertFalse(loginResult!, "Login should fail")
        XCTAssertNotNil(loginError, "There should be an error")
        XCTAssertEqual(loginError, LoginViewModel.LoginError.emptyFields, "error should be about the empty fields")
    }
}

class MockAuthenticationService: AuthenticationServiceProtocol {
    var loginResult = false
    var loginError: AlamofireError?
    func login(email: String, password: String, completion: @escaping (Bool, AlamofireError?) -> Void) {
        completion(loginResult, loginError)
    }
}

class MockNetworkingService: NetworkingServiceProtocol {

    var hasInternet = false

    func hasInternetConnection() -> Bool {
        return self.hasInternet
    }
}
