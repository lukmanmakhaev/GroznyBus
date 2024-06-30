//
//  AdminBusses.swift
//  GroznyBus
//
//  Created by Lukman Makhaev on 29.06.2024.
//

import SwiftUI

struct AdminBussesView: View {
    @EnvironmentObject var adminViewModel: AdminViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State var bus: Bus = Bus(id: UUID(), name: "103", stopIds: [])
    
    var body: some View {
        Text("Busses View Administration")
        
        NavigationLink {
            
            TextField("Stop name", text: $bus.name)
            
            
            Button {
                adminViewModel.saveBus(bus)
            } label: {
                Text("Save")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.accent)
                    .cornerRadius(15)
            }

            
        } label: {
            Text("Add Bus 🚏")
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.accent)
                .cornerRadius(15)
        }
    }
}

#Preview {
    AdminBussesView()
        .environmentObject(AdminViewModel())
        .environmentObject(HomeViewModel())
}
