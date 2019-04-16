//
//  ADZPlacementContent.swift
//  AdzerkSDK
//
//  Created by Ben Scheirman on 8/17/15.
//  Copyright (c) 2015 Adzerk. All rights reserved.
//

import Foundation

/**
    Each `ADZPlacementDecision` one or more `ADZPlacementContent` instances. 
    Combined, the these represent the creative that should be displayed. 
    A creative may contain a CSS stylesheet and a block of HTML. 
    This would be represented as two contents, one with the type `css` and one 
    with the type `html`.
*/
public struct ADZPlacementContent : Codable {
    /** 
        Indicates the type of content.
        Examples: `css`, `html`, `js`, `js-external`, or `raw`.
    */
    
    public let type: String?
    
    /* If the content uses a predefined template, this will be set to the name of the template. */
    
    public let template: String?
    
    /* Contains the template data used to build the content. */
    
    public let data: TemplateData?
    
    /* The rendered body of the content. */
    
    public let body: String?
    
    public struct TemplateData: Codable {
        public let imageUrl: String?
        public let title: String?
        public let width, height: Int?
        public let customData: CustomData?
        
        public struct CustomData: Codable {
            public let hashString: String?
            public let customPixel: String?
            enum CodingKeys: String, CodingKey {
                case hashString = "hash"
                case customPixel = "customPx"
            }
        }
    }
}
