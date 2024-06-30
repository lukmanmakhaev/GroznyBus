//
//  AdminStopsView.swift
//  GroznyBus
//
//  Created by Lukman Makhaev on 29.06.2024.
//

import SwiftUI

struct AdminStopsView: View {
    @EnvironmentObject var adminViewModel: AdminViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State var bus: Bus = Bus(id: UUID(), name: "", stopIds: ["Sadovoe"])
    
    var body: some View {
        
        NavigationStack {
            
            List {
                ForEach(homeViewModel.stops) { stop in
                    Text("\(stop.name)")
                }
            }

            NavigationLink {
                
                TextField("Bus name", text: $bus.name)
                
                HStack {
                    Text("Stops:")
                    
                    if let stopIds = bus.stopIds {
                        ForEach(stopIds, id: \.self) { stop in
                            Text("\(stop)")
                        }
                    }
                }
                
            } label: {
                Text("Add Bus 🚐")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.accent)
                    .cornerRadius(15)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    AdminStopsView()
        .environmentObject(AdminViewModel())
        .environmentObject(HomeViewModel())
}
