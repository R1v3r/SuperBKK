//
//  Route.swift
//  SuperBkk
//
//  Created by Tamás Czigány on 2018. 02. 12..
//  Copyright © 2018. Tamás Czigány. All rights reserved.
//

import Foundation

struct Route {
    
    let id: String
    let shortName: String
    let description: String
    let type: String
    let color: String
    let textColor: String
    
}

extension Route: JsonObject {
    internal var jsonValue: Json {
        var json: Json = [:]
        
        json["id"] = self.id as AnyObject?
        json["shortName"] = self.shortName as AnyObject?
        json["description"] = self.description as AnyObject?
        json["type"] = self.type as AnyObject?
        json["color"] = self.color as AnyObject?
        json["textColor"] = self.color as AnyObject?
        
        return json
    }
    
    init(json: Json) throws {
        guard
            let id = json["id"] as? String,
            let shortName = json["shortName"] as? String,
            let description = json["description"] as? String,
            let type = json["type"] as? String,
            let color = json["color"] as? String,
            let textColor = json["textColor"] as? String
            else {
                throw JsonError.parse
        }
        
        self.id = id
        self.shortName = shortName
        self.description = description
        self.type = type
        self.color = color
        self.textColor = textColor
    }
}
