//
//  TimesCollectionViewCell.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 15.12.2024.
//

import UIKit

class TimesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TimesCollectionViewCell"
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.backgroundColor = .black
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.mainYellow.cgColor
        label.layer.cornerRadius = 8
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.backgroundColor = .red
        contentView.clipsToBounds = true
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
