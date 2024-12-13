//
//  BarberModel.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 12.12.2024.
//

import Foundation

struct Barber: Codable {
    let name: String
    let surname: String
    let phoneNumber: String
    let address: String
    let workingHours: String
    let appointments: [Appointment]?
}
