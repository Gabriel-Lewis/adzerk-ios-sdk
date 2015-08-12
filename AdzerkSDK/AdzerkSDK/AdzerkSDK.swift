//
//  AdzerkSDK.swift
//  AdzerkSDK
//
//  Created by Ben Scheirman on 8/10/15.
//  Copyright (c) 2015 Adzerk. All rights reserved.
//

import Foundation

public class AdzerkSDK {
    public static var defaultNetworkId: Int?
    public static var defaultSiteId: Int?
    
    public init() {
    }
    
    public func requestPlacementInDiv(div: String, adTypes: [Int], completion: (ADZPlacementResponse) -> ()) {
        if let placement = ADZPlacement(divName: div, adTypes: adTypes) {
            requestPlacement(placement, completion: completion)
        }
    }
    
    public func requestPlacement(placement: ADZPlacement, completion: (ADZPlacementResponse) -> ()) {
        if let request = buildPlacementRequest(placement) {
            let task = session.dataTaskWithRequest(request) {
                data, response, error in
                
                if let error = error {
                    completion(.Error(error))
                } else {
                    let http = response as! NSHTTPURLResponse
                    if http.statusCode == 200 {
                        completion(.Success(data))
                    } else {
                        let bodyString = (NSString(data: data, encoding: NSUTF8StringEncoding) as? String) ?? "<no body>"
                        completion(.BadRequest(http.statusCode, bodyString))
                    }
                }
                
            }
            task.resume()
        }
    }
    
    // MARK - private
    
    lazy var sessionConfiguration: NSURLSessionConfiguration = {
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        config.HTTPAdditionalHeaders = [
            "Content-Type" : "application/json",
            "Accept" : "application/json"
        ]
        return config
    }()
    
    lazy var session: NSURLSession = {
        return NSURLSession(configuration: self.sessionConfiguration)
    }()
    
    private var baseURL: NSURL {
        return NSURL(string: "https://engine.adzerk.net/api/v2")!
    }
    
    private let requestTimeout: NSTimeInterval = 15
    
    private func buildPlacementRequest(placement: ADZPlacement) -> NSURLRequest? {
        let url = baseURL
        var request = NSMutableURLRequest(URL: url, cachePolicy: .UseProtocolCachePolicy, timeoutInterval: requestTimeout)
        request.HTTPMethod = "POST"
        
        let body = [
            "placements": [
                [
                    "divName"  : placement.divName,
                    "networkId": placement.networkId,
                    "siteId"   : placement.siteId,
                    "adTypes"  : placement.adTypes,
                    "eventIds" : placement.eventIds,
                    "zoneIds"  : placement.zoneIds,
                ]
            ],
            "isMobile": true
        ]
        
//            {
//                "placements": [
//                {
//                "divName": "div1",
//                "networkId": 123,
//                "siteId": 456,
//                "adTypes": [5],
//                "eventIds": [12,13,14],
//                "properties": {
//                "foo": 42,
//                "bar": "example",
//                "baz": ["one", "two"]
//                }
//                },
//                {
//                "divName": "div2",
//                "networkId": 123,
//                "siteId": 456,
//                "adTypes": [4,5,6]
//                }
//                ],
//                "user" : {
//                    "key": "ad39231daeb043f2a9610414f08394b5"
//                },
//                "keywords": ["foo", "bar", "baz"],
//                "referrer": "...",
//                "time": 1234567890,
//                "ip": "10.123.123.123",
//                "blockedCreatives": [123, 456],
//                "flightViewTimes": {
//                    "1234": [1234567890, 1234567891]
//                },
//                "isMobile": true
//        }
        println("Posting \(body)")
        var error: NSError?
        if let data = NSJSONSerialization.dataWithJSONObject(body, options: .PrettyPrinted, error: &error) {
            request.HTTPBody = data
            println("JSON: \(NSString(data: data, encoding: NSUTF8StringEncoding)!)")
            return request
        } else {
            println("Error building placement request: \(error)")
            return nil
        }
    }
}

public enum ADZPlacementResponse {
    case Success(NSData)
    case BadRequest(Int, String)
    case Error(NSError)
}