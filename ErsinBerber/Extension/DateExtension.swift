//
//  DateExtension.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 16.12.2024.
//

import Foundation

extension Date {
    
    func dateToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.calendar = Calendar(identifier: .gregorian)
        return formatter.string(from: self)
    }
    
    func convertToFormattedDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.calendar = Calendar(identifier: .gregorian)
        
        // Date'i formatlı bir stringe çevir
        let dateString = formatter.string(from: self)
        
        // Oluşan string'i tekrar Date'e çevir
        return formatter.date(from: dateString)
    }

}


extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.calendar = Calendar(identifier: .gregorian)
        return formatter.date(from: self)
    }
}


