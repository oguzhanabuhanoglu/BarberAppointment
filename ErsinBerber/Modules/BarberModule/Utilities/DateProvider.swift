//
//  DateProvider.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 20.12.2024.
//

import Foundation
import UIKit

// Tarih Modeli
struct CalendarDate {
    let date: Date
    let day: Int
    let weekday: String
    let monthName: String
    let year: Int
    
    func convertToFormattedDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.calendar = Calendar(identifier: .gregorian)
        
        // Date'i formatlı bir stringe çevir
        let dateString = formatter.string(from: self.date)
        
        // Oluşan string'i tekrar Date'e çevir
        return formatter.date(from: dateString)
    }
}

// Tarih sağlayıcı sınıfı
class DateProvider {
    private let calendar: Calendar
    private let dayFormatter: DateFormatter
    private let monthFormatter: DateFormatter

    init() {
        // Takvim ve formatlayıcıları başlat
        calendar = Calendar(identifier: .gregorian)
        dayFormatter = DateFormatter()
        dayFormatter.locale = Locale(identifier: "tr_TR") // Türkçe yerel ayar
        dayFormatter.dateFormat = "EEEE" // Tam gün adı

        monthFormatter = DateFormatter()
        monthFormatter.locale = Locale(identifier: "tr_TR") // Türkçe yerel ayar
        monthFormatter.dateFormat = "MMMM" // Tam ay adı
    }

    func generateDates(startingFrom startDate: Date, daysBefore: Int, daysAfter: Int) -> [CalendarDate] {
        var dates: [CalendarDate] = []

        // Belirli tarih aralığında dolaş
        for offset in -daysBefore...daysAfter {
            if let date = calendar.date(byAdding: .day, value: offset, to: startDate) {
                let day = calendar.component(.day, from: date)
                let year = calendar.component(.year, from: date)
                let weekdayName = dayFormatter.string(from: date)
                let monthName = monthFormatter.string(from: date)

                // Tarihi modele dönüştür
                let calendarDate = CalendarDate(
                    date: date,
                    day: day,
                    weekday: weekdayName.capitalized,
                    monthName: monthName.capitalized,
                    year: year
                )
                dates.append(calendarDate)
            }
        }
        return dates
    }
}
