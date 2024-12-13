//
//  CustomComponents.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 4.12.2024.
//

//import Foundation
//import UIKit
//
//class BarberView: UIView {
//    
//    private let artistImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.borderWidth = 1
//        imageView.layer.borderColor = UIColor.black.cgColor
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//    
//    private let artistNameLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .black
//        label.textAlignment = .center
//        label.font = .systemFont(ofSize: 14, weight: .bold)
//        return label
//    }()
//    
//    init(image: UIImage, name: String) {
//        super.init(frame: .zero)
//        backgroundColor = UIColor(red: 255/255, green: 214/255, blue: 10/255, alpha: 1.0)
//        self.artistImageView.image = image
//        self.artistNameLabel.text = name
//        addSubview(artistImageView)
//        addSubview(artistNameLabel)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        let width = frame.width
//        let height = frame.height
//        
//        artistImageView.frame = CGRect(x: width * 0.2, y: height * 0.1, width: width * 0.6, height: width * 0.6)
//        artistImageView.layer.cornerRadius = artistImageView.frame.width / 2
//        
//        artistNameLabel.frame = CGRect(x: width * 0.05, y: artistImageView.frame.maxY + 10, width: width * 0.9, height: 20)
//    }
//}
