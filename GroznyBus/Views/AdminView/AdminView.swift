//
//  AdminView.swift
//  GroznyBus
//
//  Created by Lukman Makhaev on 28.06.2024.
//

import SwiftUI

struct AdminView: View {
    @EnvironmentObject var adminViewModel: AdminViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State var bus: Bus = Bus(id: UUID(), name: "", stopIds: ["Sadovoe"])
    
    @State var stopIds: [String] = []
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                Picker(selection: $adminViewModel.selection, label: Text("test")) {
                    Text("Busses").tag(0)
                    Text("Stops").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                switch adminViewModel.selection {
                case 0:
                    
                    List {
                        ForEach(homeViewModel.buses) { bus in
                           BusItemView(bus: bus)
                        }
                    }
                    
                case 1:
                    ZStack {
                        VStack {
                            List {
                                ForEach(homeViewModel.stops) { stop in
                                    StopItemView(stop: stop)
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
                                    .padding()
                            }
                        }
                    }
                    
                default:
                    AdminBussesView()
                }
                
            }
        }
        .environmentObject(adminViewModel)
        .environmentObject(homeViewModel)
    }
}

#Preview {
    AdminView()
        .environmentObject(AdminViewModel())
        .environmentObject(HomeViewModel())
}
