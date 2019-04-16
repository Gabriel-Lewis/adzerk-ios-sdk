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
    let id: Int
    public let url: String
}
