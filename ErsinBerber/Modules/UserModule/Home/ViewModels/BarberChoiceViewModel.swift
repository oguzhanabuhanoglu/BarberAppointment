//
//  HomeViewModel.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 13.12.2024.
//

import Foundation
import Combine

class BarberChoiceViewModel {
    
    @Published var barbers: [Barber] = []
    private var cancellables = Set<AnyCancellable>()
    
    @Published var appointments: [Appointment] = []
    
    init() {
        getBarbers()
    }
    
    func getBarbers() {
        DatabaseManager.shared.getAllBarbers()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching barbers: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] barbers in
                self?.barbers = barbers
            })
            .store(in: &cancellables)
    }
    
    
    func getAppointmentsForBarber(barberName: String) {
        // Barber name'e göre randevuları çekiyoruz
        DatabaseManager.shared.getAppointmentsForBarber(barberName: barberName)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] appointments in
                self?.appointments = appointments
            }
            .store(in: &cancellables)
    }
    
    
}

