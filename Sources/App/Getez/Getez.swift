//
//  File.swift
//  
//
//  Created by alex on 15/05/21.
//

import Foundation
import Vapor
import NIO

class Getez : Middleware {
    
    var routes : NSMutableDictionary = [:]
    
    init(_ routes : NSMutableDictionary) {
        self.routes = routes
    }
    
    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        
        let path = request.url.path
        
        print(path)
        
        if path == "/remove"{
            
            routes.removeAllObjects()
            
            return request.eventLoop
                .makeSucceededFuture(Response(status: .ok, version: .http1_1, headers: [:], body: Response.Body.init()))
        }
        
        let getendpoints : [DynamicRoute] = (routes["GET"] as? [DynamicRoute]) ?? []
        
        for route in getendpoints {
            if path == route.route {
                return request.eventLoop
                    .makeSucceededFuture(Response(status: .ok, version: .http1_1, headers: [:], body: Response.Body.init(data: route.staticResponse.data(using: .utf8)!)))
            
            }
        }
        
        return request.eventLoop
            .makeSucceededFuture(Response(status: .notFound, version: .http1_1, headers: [:], body: Response.Body.init()))
    }
    
}
