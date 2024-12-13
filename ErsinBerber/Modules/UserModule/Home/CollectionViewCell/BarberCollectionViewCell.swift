//
//  BarberCollectionViewCell.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 13.12.2024.
//

import UIKit

class BarberCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "barberCollectionViewCell"
    
    private let barberImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let barberNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.backgroundColor = .mainYellow
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.addSubview(barberImageView)
        contentView.addSubview(barberNameLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = contentView.frame.width
        let height = contentView.frame.height
        
        barberImageView.frame = CGRect(x: width * 0.2, y: height * 0.1, width: width * 0.6, height: width * 0.6)
        barberImageView.layer.cornerRadius = barberImageView.frame.width / 2
        
        barberNameLabel.frame = CGRect(x: width * 0.05, y: barberImageView.frame.maxY + 10, width: width * 0.9, height: 20)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        barberImageView.image = nil
        barberNameLabel.text = nil
    }
    
    public func configure(with image : UIImage, name: String){
        barberImageView.image = image
        barberNameLabel.text = name
      }
}

