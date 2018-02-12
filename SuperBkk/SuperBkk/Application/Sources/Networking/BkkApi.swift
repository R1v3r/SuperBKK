//
//  BkkApi.swift
//  SuperBkk
//
//  Created by Tamás Czigány on 2018. 02. 12..
//  Copyright © 2018. Tamás Czigány. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

public enum BkkApi: URLRequestConvertible {
    static let baseURLPath = "http://futar.bkk.hu/bkk-utvonaltervezo-api/ws/otp/api/where/arrivals-and-departures-for-stop.json?stopId="
    
    case post
    case get
    case stop(String)
    
    var method: HTTPMethod {
        switch self {
        case .post:
            return .post
        case .get:
            return .get
        case .stop:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .post:
            return ""
        case .get:
            return ""
        case .stop(let stopId):
            return stopId
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let parameters: [String: Any] = {
            switch self {
            default:
                return [:]
            }
        }()
        
        let url = try SuperchargeApi.baseURLPath.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10 * 1000)
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
