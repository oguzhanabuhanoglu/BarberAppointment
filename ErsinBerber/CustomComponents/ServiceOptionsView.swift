//
//  ServiceOptionsView.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 11.12.2024.
//

import Foundation
import UIKit

class ServiceOptionsView: UIView {
    
    private let isSelectedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .mainYellow
        imageView.image = UIImage(systemName: "circle")
        return imageView
    }()
    
    private let serviceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    var isSelected: Bool = false {
        didSet {
            updateSelectionState()
        }
    }
    
    init(service: String, duration: String, price: String) {
        super.init(frame: .zero)
        backgroundColor = .viewBackground
        layer.borderWidth = 1
        layer.cornerRadius = 10
        
        addSubviews()
        
        self.serviceLabel.text = service
        self.durationLabel.text = duration
        self.priceLabel.text = price
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleTap() {
        isSelected.toggle()
    }
    
    private func updateSelectionState() {
        if isSelected {
            layer.borderColor = UIColor.mainYellow.cgColor
            isSelectedImageView.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            layer.borderColor = UIColor.clear.cgColor
            isSelectedImageView.image = UIImage(systemName: "circle")
        }
    }
    
    func addSubviews() {
        addSubview(isSelectedImageView)
        addSubview(serviceLabel)
        addSubview(durationLabel)
        addSubview(priceLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let width = frame.width
        let height = frame.height
        
        isSelectedImageView.frame = CGRect(x: 5, y: height * 0.5 - 13, width: 26, height: 26)
        serviceLabel.frame = CGRect(x: 40, y: height * 0.15, width: width * 0.7, height: 25)
        durationLabel.frame = CGRect(x: 40, y: serviceLabel.frame.maxY + 10, width: width * 0.7, height: 25)
        priceLabel.frame = CGRect(x: serviceLabel.frame.maxX, y: height * 0.1, width: width * 0.15, height: 25)
        
    }
    
}
