//
//  ADZPlacementResponse.swift
//  AdzerkSDK
//
//  Created by Ben Scheirman on 8/14/15.
//  Copyright (c) 2015 Adzerk. All rights reserved.
//

import Foundation

/**
    Top level response object for placement requests.
    Documentation can be found at: http://help.adzerk.com/hc/en-us/articles/203193935-Response
*/
public struct ADZPlacementResponse: Codable {
    public struct User: Codable {
        let key: String?
    }
    
    public struct Decisions: Codable {
        public let sponsoredThumb: ADZPlacementDecision?
        public let sponsoredPage: ADZPlacementDecision?
        public let sponsoredCompanion: ADZPlacementDecision?
        
        enum CodingKeys: String, CodingKey {
            case sponsoredThumb = "sponsored_thumb"
            case sponsoredPage = "sponsored_page"
            case sponsoredCompanion = "sponsored_companion"
        }
    }
    
    public let decisions: Decisions?
    public let user: User?
}


