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
        
        // Then
    }
}


class MockAlamofire: AlamofireWrapperProtocol {
    var response: AlamofireResponse?
    func request(url: URL, method: HTTPMethod, completion: @escaping (AlamofireResponse) -> Void) {
        <#code#>
    }
    
    func request(url: URL, method: HTTPMethod, parameters: Parameters?, completion: @escaping (AlamofireResponse) -> Void) {
        <#code#>
    }
    
    func request(url: URL, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders, completion: @escaping (AlamofireResponse) -> Void) {
    
        completion(response ?? AlamofireResponse())
    }

}
