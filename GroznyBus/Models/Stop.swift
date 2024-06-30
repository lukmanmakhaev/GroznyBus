//
//  Stop.swift
//  GroznyBus
//
//  Created by Lukman Makhaev on 22.06.2024.
//

import Foundation

struct Stop: Identifiable, Codable {
    let id: UUID
    var name: String
    var adres: String
    var latitude: Double
    var longitude: Double
    var busIds: [String]?
    
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [
            "id": id.uuidString,
            "name": name,
            "adres": adres,
            "latitude": latitude,
            "longitude": longitude
        ]
        
        if let busIds = busIds {
            dictionary["busIds"] = busIds
        }
        
        return dictionary
    }
    
    init(id: UUID, name: String, latitude: Double, longitude: Double, adres: String, busIds: [String]?) {
        self.id = id
        self.name = name
        self.adres = adres
        self.latitude = latitude
        self.longitude = longitude
        self.busIds = busIds
    }
    
    init?(dictionary: [String: Any]) {
        guard let idString = dictionary["id"] as? String,
              let id = UUID(uuidString: idString),
              let name = dictionary["name"] as? String,
              let adres = dictionary["adres"] as? String,
              let latitude = dictionary["latitude"] as? Double,
              let longitude = dictionary["longitude"] as? Double,
              let busIdsArray = dictionary["busIds"] as? [String] else { return nil }
        
        self.id = id
        self.name = name
        self.adres = adres
        self.latitude = latitude
        self.longitude = longitude
        self.busIds = busIdsArray
        
    }
}

