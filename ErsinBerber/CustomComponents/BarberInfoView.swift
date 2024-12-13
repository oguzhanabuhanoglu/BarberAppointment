//
//  ArtistInfoView.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 4.12.2024.
//

import Foundation
import UIKit

class BarberInfoView: UIView {
    
    var barber: Barber
    
    private let artistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        imageView.image = UIImage(named: "me")
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "Ersin Güven"
        return label
    }()
    
    private let phoneNumberlabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "05077771181"
        return label
    }()
    
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "İstanbul / Beşiktaş"
        return label
    }()
    
    private let workHoursLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "11:00 - 21:00"
        return label
    }()
    
    
    init(barber: Barber) {
        self.barber = barber
        super.init(frame: .zero)
        layer.cornerRadius = 10
        backgroundColor = UIColor(red: 255/255, green: 214/255, blue: 10/255, alpha: 1.0)
       
        artistNameLabel.text = "\(barber.name) \(barber.surname)"
        phoneNumberlabel.text = barber.phoneNumber
        locationLabel.text = barber.address
        workHoursLabel.text = barber.workingHours
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = frame.width
        let height = frame.height
    
        let imageSize = width * 0.25
        artistImageView.frame = CGRect(x: 10, y: 15, width: imageSize, height: imageSize)
        artistImageView.layer.cornerRadius = imageSize / 2
        addSubview(artistImageView)
        
        artistNameLabel.frame = CGRect(x: artistImageView.frame.maxX + 15, y: 15, width: width * 0.7, height: 25)
        addSubview(artistNameLabel)
        
        phoneNumberlabel.frame = CGRect(x: artistImageView.frame.maxX + 15, y: artistNameLabel.frame.maxY + 5, width: width * 0.7, height: 25)
        addSubview(phoneNumberlabel)
        
        locationLabel.frame = CGRect(x: artistImageView.frame.maxX + 15 , y: phoneNumberlabel.frame.maxY + 5, width: width * 0.7, height: 25)
        addSubview(locationLabel)
        
        workHoursLabel.frame = CGRect(x: artistImageView.frame.maxX + 15 , y: locationLabel.frame.maxY + 5, width: width * 0.7, height: 25)
        addSubview(workHoursLabel)
    }
}
