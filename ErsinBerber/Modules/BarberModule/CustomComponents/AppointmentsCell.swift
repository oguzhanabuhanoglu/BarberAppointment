//
//  AppointmentsTableViewCell.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 22.12.2024.
//

import UIKit

class AppointmentsCell: UITableViewCell {
    
    static let identifier = "AppointmentsTableViewCell"
    
    private let clientNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()
    
    private let serviceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textColor = .lightGray
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        contentView.addSubview(clientNameLabel)
        contentView.addSubview(serviceLabel)
        contentView.addSubview(timeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = contentView.frame.width
        let height = contentView.frame.height
        
        clientNameLabel.frame = CGRect(x: 5, y: height * 0.2, width: width * 0.7, height: height * 0.2)
        serviceLabel.frame = CGRect(x: 5, y: clientNameLabel.frame.maxY + (height * 0.2), width: width * 0.7, height: height * 0.2)
        timeLabel.frame = CGRect(x: width * 0.75, y: height * 0.3, width: width * 0.25, height: height * 0.4)
    }
    
    func configure(clientName: String, service: String, time: String) {
        clientNameLabel.text = clientName
        serviceLabel.text = service
        timeLabel.text = time
    }

}
