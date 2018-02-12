//
//  Stop.swift
//  SuperBkk
//
//  Created by Tamás Czigány on 2018. 02. 12..
//  Copyright © 2018. Tamás Czigány. All rights reserved.
//

import Foundation

struct Stop {
    
    let stop_id: String
    let stop_name: String
    let stop_code: String
    let stop_lat: Double
    let stop_lon: Double
    
}

extension Stop: JsonObject {
    internal var jsonValue: Json {
        var json: Json = [:]
        
        json["stop_id"] = self.stop_id as AnyObject?
        json["stop_name"] = self.stop_name as AnyObject?
        json["stop_code"] = self.stop_code as AnyObject?
        json["stop_lat"] = self.stop_lat as AnyObject?
        json["stop_lon"] = self.stop_lon as AnyObject?
        
        return json
    }
    
    init(json: Json) throws {
        guard
            let stop_id = json["id"] as? String,
            let stop_name = json["country"] as? String,
            let stop_code = json["zipcode"] as? String,
            let stop_lat = json["name"] as? Double,
            let stop_lon = json["state"] as? Double
            else {
                throw JsonError.parse
        }
        
        self.stop_id = stop_id
        self.stop_name = stop_name
        self.stop_code = stop_code
        self.stop_lat = stop_lat
        self.stop_lon = stop_lon
    }
}
