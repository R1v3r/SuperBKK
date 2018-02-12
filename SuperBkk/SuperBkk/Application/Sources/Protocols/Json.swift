//
//  Json.swift
//  SuperBkk
//
//  Created by Tamás Czigány on 2018. 02. 12..
//  Copyright © 2018. Tamás Czigány. All rights reserved.
//

import Foundation
import PromiseKit

typealias Json = [String:AnyObject]

enum JsonError: Error
{
    case parse
}


protocol JsonObject {
    
    init(json: Json) throws
    
    var jsonValue: Json { get }
}

extension JsonObject {
    
    static func parse(from: AnyObject) -> Promise<Self> {
        return Promise { fulfill, reject in
            guard let json = from as? Json else {
                return reject(JsonError.parse)
            }
            do {
                let object = try self.init(json: json)
                fulfill(object)
            } catch {
                reject(error)
            }
        }
    }
    
    static func parseList(from: AnyObject) -> Promise<[Self]> {
        return Promise { fulfill, reject in
            guard let json = from as? [Json] else {
                return reject(JsonError.parse)
            }
            do {
                let objects = try json.map { try self.init(json: $0) }
                fulfill(objects)
            } catch {
                reject(error)
            }
        }
    }
}
