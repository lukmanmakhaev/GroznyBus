//
//  GroznyBusApp.swift
//  GroznyBus
//
//  Created by Lukman Makhaev on 20.06.2024.
//

import SwiftUI
import FirebaseCore

@main
struct GroznyBusApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
