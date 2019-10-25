//
//  NetworkResponse.swift
//  ArchitectureSample
//
//  Created by Catalina Turlea on 10/12/19.
//  Copyright © 2019 Catalina Turlea. All rights reserved.
//

import Alamofire

// You want to be able to mock the responses as well
// To check parsings and logic when errors are received
protocol NetworkResponseProtocol {
    var data: Data? { get }
    var error: NetworkError? { get }
}

struct NetworkError {
    var error: Error?
    var code: Int
}

class NetworkResponse: NetworkResponseProtocol {
    
    var response: DefaultDataResponse?
    
    var data: Data?
    
    var error: NetworkError?
    
    init() { }
    
    init(response: DefaultDataResponse) {
        self.response = response
        self.data = response.data

        let statusCode = response.response?.statusCode ?? -1
        self.error = NetworkError(error: response.error, code: statusCode)
    }

}
