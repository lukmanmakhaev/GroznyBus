//
//  BusModel.swift
//  GroznyBus
//
//  Created by Lukman Makhaev on 22.06.2024.
//

import Foundation

struct Bus: Identifiable, Codable {
    
    let id: UUID
    var name: String
    var stopIds: [String]?
    var stops: [Stop]?
    
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [
            "id": id.uuidString,
            "name": name
        ]
        
        if let stopIds = stopIds {
            dictionary["stopIds"] = stopIds
        }
        
        if let stops = stops {
            dictionary["stops"] = stops.map { $0.toDictionary() }
        }
        
        return dictionary
    }
    
    init(id: UUID, name: String, stopIds: [String]?, stops: [Stop]? = nil) {
        self.id = id
        self.name = name
        self.stopIds = stopIds
        self.stops = stops
    }
    
    init?(dictionary: [String: Any]) {
        guard let idString = dictionary["id"] as? String,
              let id = UUID(uuidString: idString),
              let name = dictionary["name"] as? String,
              let stopIdsArray = dictionary["stopIds"] as? [String] else { return nil }

        self.id = id
        self.name = name
        self.stopIds = stopIdsArray
        
        if let stopsArray = dictionary["stops"] as? [[String: Any]] {
            self.stops = stopsArray.compactMap { Stop(dictionary: $0) }
        } else {
            self.stops = nil
        }
    }
}
