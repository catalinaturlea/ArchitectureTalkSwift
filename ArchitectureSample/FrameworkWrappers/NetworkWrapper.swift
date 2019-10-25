//
//  NetworkWrapper.swift
//  ArchitectureSample
//
//  Created by Catalina Turlea on 10/12/19.
//  Copyright © 2019 Catalina Turlea. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkWrapperProtocol {
    
    // Provide method with reduced number of parameters for the most common cases - like no parameters and the same headers
    func triggerRequest(url: URL, method: HTTPMethod, completion: @escaping (NetworkResponse) -> Void)
    
    func triggerRequest(url: URL, method: HTTPMethod, parameters: Parameters?, completion: @escaping (NetworkResponse) -> Void)
    
    // Provide a method that can manipulate all the parameters
    func triggerRequest(url: URL, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders, completion: @escaping (NetworkResponse) -> Void)
}

class NetworkWrapper: NetworkWrapperProtocol {
    
    private let sessionManager: SessionManager
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120

        sessionManager = SessionManager(configuration: configuration)
    }
    
    func triggerRequest(url: URL, method: HTTPMethod, completion: @escaping (NetworkResponse) -> Void) {
        triggerRequest(url: url, method: method, parameters: nil, encoding: URLEncoding.default, headers: [:], completion: completion)
    }
    
    func triggerRequest(url: URL, method: HTTPMethod, parameters: Parameters?,completion: @escaping (NetworkResponse) -> Void) {
        triggerRequest(url: url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: [:], completion: completion)
    }
    
    // Wrapper for the method to make a network request with all the necessary parameters
    func triggerRequest(url: URL,
                 method: HTTPMethod,
                 parameters: Parameters?,
                 encoding: ParameterEncoding,
                 headers: HTTPHeaders,
                 completion: @escaping (NetworkResponse) -> Void) {
        
        // Create the request with the given parameters
        let request = sessionManager.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
        
        // Trigger the request and parse the response
        request.response(queue: DispatchQueue.global()) { (response) in
            
            // Send back the response in the completion block
            let response = NetworkResponse(response: response)
            completion(response)
        }
    }
}
