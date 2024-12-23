//
//  LocalDataManager.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 22.12.2024.
//

import Foundation

class LocalDataManager {
    
    static let shared = LocalDataManager()
    
    func saveBarberToUserDefaults(barber: Barber) {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(barber)
            UserDefaults.standard.set(encoded, forKey: "currentBarber")
        } catch {
            print("Failed to encode barber: \(error)")
        }
    }
    
    
    func loadBarberFromUserDefaults() -> Barber? {
        if let savedBarberData = UserDefaults.standard.object(forKey: "currentBarber") as? Data {
            let decoder = JSONDecoder()
            do {
                let loadedBarber = try decoder.decode(Barber.self, from: savedBarberData)
                return loadedBarber
            } catch {
                print("Failed to decode barber: \(error)")
            }
        }
        return nil
    }
    
}
