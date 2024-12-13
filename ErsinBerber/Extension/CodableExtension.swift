//
//  CodableExtension.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 10.12.2024.
//

import Foundation

//encode edilen datayı [string : any] dictionary yapacak.firestore verilerini işlemek için. STRUCT TO JSON
extension Encodable {
    func asDictionary() -> [String : Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String : Any]
        return json
    }
}

//JSON TO STRUCT
extension Decodable {
    init?(with dictionary : [String : Any]){
        guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) else {
            return nil
        }
        guard let result = try? JSONDecoder().decode(Self.self, from: data) else {
            return nil
        }
        self = result
    }
}
