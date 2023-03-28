//
//  SegmentsData.swift
//  
//
//  Created by Artur Sardaryan on 29.03.2023.
//

import UIKit

public struct SegmentsStyle {
    public let height: CGFloat
    public let titleMarginHorizontal: CGFloat
    public let font: UIFont
    public let textColor: UIColor
    public let selectedColor: UIColor
    public let separatorColor: UIColor
    
    public init(height: CGFloat, titleMarginHorizontal: CGFloat, font: UIFont, textColor: UIColor, selectedColor: UIColor, separatorColor: UIColor) {
        self.height = height
        self.titleMarginHorizontal = titleMarginHorizontal
        self.font = font
        self.textColor = textColor
        self.selectedColor = selectedColor
        self.separatorColor = separatorColor
    }
}

struct SegmentsData {
    let titles: [String]
    let style: SegmentsStyle
}
