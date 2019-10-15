//
//  AlamofireWrapper.swift
//  ArchitectureSample
//
//  Created by Catalina Turlea on 10/12/19.
//  Copyright © 2019 Catalina Turlea. All rights reserved.
//

import Foundation
import Alamofire

protocol AlamofireWrapperProtocol {
    
    // Provide method with reduced number of parameters for the most common cases - like no parameters and the same headers
    func request(url: URL, method: HTTPMethod, completion: @escaping (AlamofireResponse) -> Void)
    
    func request(url: URL, method: HTTPMethod, parameters: Parameters?, completion: @escaping (AlamofireResponse) -> Void)
    
    // Provide a method that can manipulate all the parameters
    func request(url: URL, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders, completion: @escaping (AlamofireResponse) -> Void)
}

class AlamofireWrapper: AlamofireWrapperProtocol {
    
    private let alamofire: SessionManager
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120

        alamofire = SessionManager(configuration: configuration)
    }
    
    func request(url: URL, method: HTTPMethod, completion: @escaping (AlamofireResponse) -> Void) {
        request(url: url, method: method, parameters: nil, encoding: URLEncoding.default, headers: [:], completion: completion)
    }
    
    func request(url: URL, method: HTTPMethod, parameters: Parameters?,completion: @escaping (AlamofireResponse) -> Void) {
        request(url: url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: [:], completion: completion)
    }
    
    func request(url: URL,
                 method: HTTPMethod,
                 parameters: Parameters?,
                 encoding: ParameterEncoding,
                 headers: HTTPHeaders,
                 completion: @escaping (AlamofireResponse) -> Void) {
        
        // Call the framework
        alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).response(queue: DispatchQueue.global()) { (response) in
            
            // Send back the response in the completion block
            let response = AlamofireResponse(response: response)
            completion(response)
        }
    }
}
