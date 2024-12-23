//
//  CalendarCollectionViewCell.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 20.12.2024.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    static let identifier = "CalendarCell"
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? .mainYellow : .clear
            contentView.layer.borderColor = UIColor.mainYellow.cgColor
            dayLabel.textColor = isSelected ? .black : .white
            weekdayLabel.textColor = isSelected ? .black : .white
            monthLabel.textColor = isSelected ? .black : .white
        }
    }
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let weekdayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .lightText
        return label
    }()
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .lightText
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let width = frame.size.width
        let height = frame.size.height
        
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.mainYellow.cgColor
        
        addSubview(dayLabel)
        dayLabel.frame = CGRect(x: width * 0.05, y: height * 0.5 - 10 , width: width * 0.9, height: 20)
        addSubview(weekdayLabel)
        weekdayLabel.frame = CGRect(x: width * 0.05, y: dayLabel.frame.minY - 20, width: width * 0.9, height: 20)
        addSubview(monthLabel)
        monthLabel.frame = CGRect(x: width * 0.05, y: dayLabel.frame.maxY, width: width * 0.9, height: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(day: Int, weekday: String, monthName: String) {
        dayLabel.text = "\(day)"
        weekdayLabel.text = weekday
        monthLabel.text = monthName
    }
}
