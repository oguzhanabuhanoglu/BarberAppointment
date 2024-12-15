//
//  TimesCollectionViewCell.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 15.12.2024.
//

import UIKit

class TimesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TimesCollectionViewCell"
    
    override var isSelected: Bool {
           didSet {
               timeLabel.backgroundColor = isSelected ? .mainYellow : .clear
           }
       }
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.mainYellow.cgColor
        label.layer.cornerRadius = 8
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.addSubview(timeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = contentView.frame.width
        let height = contentView.frame.height
        
        timeLabel.frame = CGRect(x: 0, y: 0, width: width, height: height)
      
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timeLabel.text = nil
    }
    
    public func configure(time: String) {
        timeLabel.text = time
    }
}
