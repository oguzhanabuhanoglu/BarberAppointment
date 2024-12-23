//
//  CreateAppointmentViewModel.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 18.12.2024.
//

import Foundation
import Combine

class CreateAppointmentViewModel {
    
    var barberName: String
    @Published var appointments: [Appointment] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(barberName: String) {
        self.barberName = barberName
        getAppointments()
    }
    
    func getAppointments() {
        DatabaseManager.shared.getAppointmentsForBarber(barberName: barberName)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] appointments in
                self?.appointments = appointments
            }
            .store(in: &cancellables)
    }
    
    
    func createAppointment(selectedDate: Date?, barber: Barber, selectedTime: String?, newAppointment: Appointment, completion: @escaping (Result<Appointment, Error>) -> Void) {
        var newAppointment = newAppointment
        print("tapped")
        
        guard let userPhoneNumber = UserDefaults.standard.string(forKey: "phoneNumber") else {
            print("Failed to find phone number in local")
            return
        }
        
        DatabaseManager.shared.findUser(with: userPhoneNumber) { user in
            guard let user = user else {
                print("Failed to find user")
                completion(.failure(NSError(domain: "AppointmentError", code: 2, userInfo: [NSLocalizedDescriptionKey: "User not found"])))
                return
            }
            
            
            guard let selectedDate = selectedDate,
                  let selectedTime = selectedTime else {
                print("Date or time is empty")
                completion(.failure(NSError(domain: "AppointmentError", code: 3, userInfo: [NSLocalizedDescriptionKey: "Date or time is empty"])))
                return
            }
            

            newAppointment.barber = barber
            newAppointment.owner = user
            newAppointment.date = selectedDate.dateToString()
            newAppointment.time = selectedTime
            

            DatabaseManager.shared.createAppointment(newAppointment: newAppointment) { success in
                if success {
                    print("SUCCESFULLY CREATED")
                    completion(.success(newAppointment))
                } else {
                    print("Error: When creating appointment")
                    completion(.failure(NSError(domain: "AppointmentError", code: 4, userInfo: [NSLocalizedDescriptionKey: "Failed to create appointment"])))
                }
            }
        }
    }

    
}

