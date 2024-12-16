//
//  DatabaseManager.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 3.12.2024.
//

import Foundation
import FirebaseFirestore
import Combine

class DatabaseManager {
    
    static let shared = DatabaseManager()
    private let database = Firestore.firestore()
    
    private init() {}
    
    public func createNewUser(newUser: User, completion: @escaping (Bool) -> Void) {
        
        let userRef = database.collection("users").document(newUser.phoneNumber)
        
        guard let data = newUser.asDictionary() else {
            completion(false)
            return
        }
        
        userRef.setData(data) { error in
            completion(error == nil)
        }
    }
    
    
    public func getAllBarbers() -> AnyPublisher<[Barber], Error> {
        let ref = database.collection("barbers")
        
        return Future { promise in
            ref.getDocuments { snapshot, error in
                if let error = error {
                    promise(.failure(error)) // Error handling
                } else if let snapshot = snapshot {
                    let barbers = snapshot.documents.compactMap { Barber(with: $0.data()) }
                    promise(.success(barbers)) // Success with barbers data
                }
            }
        }
        .eraseToAnyPublisher() // Return a publisher
    }
    
    
    // MARK: Find specific barber and user fot authentication checks.
    public func findUser(with phoneNumber: String, completion: @escaping (User?) -> Void) {
        let ref = database.collection("users")
        ref.getDocuments { snapshot, error in
            guard let users = snapshot?.documents.compactMap({ User(with: $0.data()) }), error == nil else {
                completion(nil)
                return
            }
            let user = users.first(where:{ $0.phoneNumber == phoneNumber})
            completion(user)
        }
    }
    
    
    public func findBarber(with phoneNumber: String, completion: @escaping (Barber?) -> Void) {
        let ref = database.collection("barbers")
        ref.getDocuments { snapshot, error in
            guard let barbers = snapshot?.documents.compactMap({ Barber(with: $0.data()) }), error == nil else {
                completion(nil)
                return
            }
            
            let barber = barbers.first(where:{ $0.phoneNumber == phoneNumber})
            completion(barber)
        }
    }
}

