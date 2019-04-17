//
//  ADZPlacementDecision.swift
//  AdzerkSDK
//
//  Created by Ben Scheirman on 8/14/15.
//  Copyright (c) 2015 Adzerk. All rights reserved.
//

import Foundation

/**
    Response structure for decisions, found in a placement response. Each decision
    will be represented as one of these.
*/
public struct ADZPlacementDecision : Codable {
    
    public let adId: Int?
    public let creativeId: Int?
    public let flightId: Int?
    public let campaignId: Int?
    
    public let clickUrl: String?
    public let impressionUrl: String?
    
    // These accessors are added for Objective-C compatibility
    public var adIdNumber: NSNumber? {
        return adId.flatMap(NSNumber.init)
    }
    
    public var creativeIdNumber: NSNumber? {
        return creativeId.flatMap(NSNumber.init)
    }
    
    public var flightIdNumber: NSNumber? {
        return flightId.flatMap(NSNumber.init)
    }
    
    /** An array of `ADZPlacementContent`, representing the actual contents
        to display for this decision, if there are any.
    */
    public let contents: [ADZPlacementContent]?
    
    /** An array of `ADZPlacementEvent`, representing the events for this decision,
        if there are any. */
    public let events: [ADZPlacementEvent]?
        
    public var description: String {
        return "ADZPlacementDecision: adId=\(adId ?? 0) creativeId=\(creativeId ?? 0)"
    }
}
