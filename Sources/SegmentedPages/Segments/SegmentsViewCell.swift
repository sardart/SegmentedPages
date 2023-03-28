//
//  SegmentsViewCell.swift
//  
//
//  Created by Artur Sardaryan on 29.03.2023.
//

import UIKit

final class SegmentsViewCell: UICollectionViewCell {
    static let reuseIdentifier = "SegmentsViewCell"
    
    private let titleLabel = UILabel()
    private let selectedSeparatorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {        
        contentView.addSubview(titleLabel)
        contentView.addSubview(selectedSeparatorView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = bounds
        selectedSeparatorView.frame = .init(x: 0, y: bounds.height - 1, width: bounds.width, height: 1)        
    }
    
    func configure(with title: NSAttributedString, isSelected: Bool, selectedColor: UIColor) {
        titleLabel.attributedText = title
        selectedSeparatorView.isHidden = !isSelected
        selectedSeparatorView.backgroundColor = selectedColor
    }
 }
