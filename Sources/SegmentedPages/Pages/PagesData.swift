//
//  PagesData.swift
//  
//
//  Created by Artur Sardaryan on 29.03.2023.
//

import UIKit

public struct PagesData {
    public struct Page {
        public let viewController: UIViewController
        public let title: String
        
        public init(viewController: UIViewController, title: String) {
            self.viewController = viewController
            self.title = title
        }
    }
    
    public let pages: [Page]
    public let segmentsStyle: SegmentsStyle
    
    public init(pages: [Page], segmentsStyle: SegmentsStyle) {
        self.pages = pages
        self.segmentsStyle = segmentsStyle
    }
}
