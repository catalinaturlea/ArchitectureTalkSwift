//
//  AlamofireResponse.swift
//  ArchitectureSample
//
//  Created by Catalina Turlea on 10/12/19.
//  Copyright © 2019 Catalina Turlea. All rights reserved.
//

import Alamofire

// You want to be able to mock the responses as well
// To check parsings and logic when errors are received
protocol AlamofireResponseProtocol {
    var data: Data? { get }
    var error: Error? { get }
}

class AlamofireResponse: AlamofireResponseProtocol {
    
    var response: DefaultDataResponse?
    
    var data: Data?
    
    var error: Error?
    
    init() {
        
    }
    
    init(response: DefaultDataResponse) {
        self.response = response
        self.data = response.data
        self.error = response.error
    }

}
