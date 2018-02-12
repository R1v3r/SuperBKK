//
//  SuperchargeApi.swift
//  SuperBkk
//
//  Created by Tamás Czigány on 2018. 02. 12..
//  Copyright © 2018. Tamás Czigány. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

public enum SuperchargeApi: URLRequestConvertible {
    
    static let baseURLPath = "http://bkk-api.supercharge.io/stops"
    
    case post
    case get
    
    var method: HTTPMethod {
        switch self {
        case .post:
            return .post
        case .get:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .post:
            return ""
        case .get:
            return ""
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        
        let url = try SuperchargeApi.baseURLPath.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10 * 1000)
        
        return try URLEncoding.default.encode(request, with: [:])
    }
}
