//
//  ContentView.swift
//  GroznyBus
//
//  Created by Lukman Makhaev on 20.06.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        TabView {
            HomeView()
                .environmentObject(homeViewModel)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    ContentView()
}
