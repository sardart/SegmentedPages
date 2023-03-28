//
//  SegmentsViewDelegate.swift
//  
//
//  Created by Artur Sardaryan on 29.03.2023.
//

import Foundation

public protocol SegmentsViewDelegate: AnyObject {
    func didSelectSegment(at index: Int)
}
