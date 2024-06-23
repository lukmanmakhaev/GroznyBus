//
//  BusModel.swift
//  GroznyBus
//
//  Created by Lukman Makhaev on 22.06.2024.
//

import Foundation

struct Bus: Identifiable, Codable {
    
    let id: UUID
    let name: String
    let route: [Stop]
    
    
}
