//
//  AdminViewModel.swift
//  GroznyBus
//
//  Created by Lukman Makhaev on 28.06.2024.
//

import Foundation
import FirebaseFirestore

class AdminViewModel: ObservableObject {
    
    @Published var selection = 0
    
    var test = "adsa"
    private let db = Firestore.firestore()
    
    func saveStop(_ stop: Stop) {
        db.collection("stops").document(stop.id.uuidString).setData(stop.toDictionary()) { error in
            if let error = error {
                print("Error saving stop: \(error.localizedDescription)")
            } else {
                print("Stop saved successfully")
            }
        }
    }
    
    func saveBus(_ bus: Bus) {
        db.collection("buses").document(bus.id.uuidString).setData(bus.toDictionary()) { error in
            if let error = error {
                print("Error saving bus: \(error.localizedDescription)")
            } else {
                print("Bus saved successfully")
            }
        }
    }
    
    
}
