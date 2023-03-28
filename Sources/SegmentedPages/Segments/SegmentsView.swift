//
//  SegmentsView.swift.swift
//  
//
//  Created by Artur Sardaryan on 29.03.2023.
//

import UIKit

final class SegmentsView: UIView {
    weak var delegate: SegmentsViewDelegate?
    
    private let style: SegmentsStyle
    private let titles: [String]
    
    var selectedIndex: Int = 0 {
        didSet {
            collectionView.reloadData()
            collectionView.scrollToItem(at: IndexPath(item: selectedIndex, section: 0),
                                        at: .centeredHorizontally,
                                        animated: true)
        }
    }

    private let separatorView = UIView()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    init(data: SegmentsData) {
        self.style = data.style
        self.titles = data.titles
        
        super.init(frame: .zero)
        setup()
    }
    
    private func attributed(title: String, isSelected: Bool) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        
        return NSAttributedString(string: title, attributes: [
            NSAttributedString.Key.font: style.font,
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.foregroundColor: isSelected ? style.selectedColor : style.textColor
        ])
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SegmentsViewCell.self, forCellWithReuseIdentifier: SegmentsViewCell.reuseIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        
        separatorView.backgroundColor = style.separatorColor
                
        addSubview(collectionView)
        addSubview(separatorView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = bounds
        separatorView.frame = .init(x: 0, y: bounds.height - 0.5, width: bounds.width, height: 0.5)
    }
}

extension SegmentsView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentsViewCell.reuseIdentifier, for: indexPath) as? SegmentsViewCell else {
            return .init()
        }
        
        let title = attributed(title: titles[indexPath.item],
                               isSelected: selectedIndex == indexPath.item)
        cell.configure(with: title,
                       isSelected: indexPath.item == selectedIndex,
                       selectedColor: style.selectedColor)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectSegment(at: indexPath.item)
    }
}

extension SegmentsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = attributed(title: titles[indexPath.item],
                               isSelected: selectedIndex == indexPath.item)
        
        let height = collectionView.bounds.height
        let size = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingRect = title.boundingRect(with: size, context: nil)
        let width = boundingRect.width + (style.titleMarginHorizontal * 2)
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}
