//
//  ADZPlacementEvent.swift
//  AdzerkSDK
//
//  Created by Ben Scheirman on 8/17/15.
//  Copyright (c) 2015 Adzerk. All rights reserved.
//

import Foundation

/** 
    Returns tracking URLs for any requested custom events.
*/
public struct ADZPlacementEvent : Codable {
    public let id: Int
    public let url: String
    public init(id: Int, url: String) {
        self.id = id
        self.url = url
    }
}
