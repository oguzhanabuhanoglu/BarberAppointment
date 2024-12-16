//
//  AppointmentModel.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 12.12.2024.
//

import Foundation

struct Appointment: Codable {
    var barber: Barber?
    var owner: User?
    var service: String?
    var date: String?
    var time: String?
}
