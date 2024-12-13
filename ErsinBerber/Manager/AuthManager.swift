//
//  AuthManager.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 3.12.2024.
//

import Foundation
import FirebaseAuth

class AuthManager {
    
    static let shared = AuthManager()
    
    enum DatabaseError : Error {
        case signUpFailed
        case newUserCreationFailed
    }
    
    // MARK: User Authentication
    func sendVerificationCode(phoneNumber: String, completion: @escaping (Bool, String?) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            if let error = error {
                print("Error sending verification code: \(error.localizedDescription)")
                if let authError = error as? NSError {
                    print("Error code: \(authError)")
                    }
                completion(false, error.localizedDescription)
                return
            }
            
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            print("Verification code sent successfully.")
        
            completion(true, nil)
        }
    }
    

    func verifyUser(isLogin: Bool, user: User, verificationCode: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {
            print("No verification ID found.")
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("Error verifying code: \(error.localizedDescription)")
                completion(.failure(DatabaseError.signUpFailed))
                return
            } else {
                completion(.success(user))
            }
            
            // This is the uid coming from firebase for users but i am not gonna use it in  this app.
//            print("User signed in successfully: \(authResult?.user.uid ?? "No UID")")
            
            if isLogin == false {
                DatabaseManager.shared.createNewUser(newUser: user) { success in
                    if success {
                        completion(.success(user))
                        print(user.name)
                    } else {
                        completion(.failure(DatabaseError.newUserCreationFailed))
                        print("database create user issue")
                    }
                }
            }
        }
    }
    
    // MARK: Barber Authentication
    func verifyBarber(barber: Barber, verificationCode: String, completion: @escaping (Result<Barber, Error>) -> Void) {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {
            print("No verification ID found.")
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("Error verifying code: \(error.localizedDescription)")
                completion(.failure(DatabaseError.signUpFailed))
                return
            } else {
                completion(.success(barber))
            }
        }
        
        
    }
   

    
}
