//
//  BusItemView.swift
//  GroznyBus
//
//  Created by Lukman Makhaev on 29.06.2024.
//

import SwiftUI

struct BusItemView: View {
    var bus: Bus
    var body: some View {
        
        HStack {
            ZStack {
                Circle()
                    .foregroundColor(.colorGray2)
                
                Image(systemName: "train.side.rear.car")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .padding(12)
                    .foregroundColor(.colorGray3)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
            .frame(width: 50, height: 50)
            
            VStack (alignment: .leading, spacing: 4) {
                
                
                Text("\(bus.name)")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                
                if let stops = bus.stops {
                    Text("\(stops[0].name) - \(stops[(bus.stopIds?.count ?? 0) - 1].name)")
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                }
                
                
            }
            .padding(.leading, 8)

            
            Spacer()
            
            VStack {
                Text("\(bus.stops?.count.description ?? "")")
                    .font(.system(size: 18))
                    .fontWeight(.regular)
            }
            .padding(.trailing, 8)
            
        }
        .frame(maxWidth: .infinity)
        .padding(8)
        
    }
}

#Preview {
    BusItemView(bus: Bus(id: UUID(), name: "103", stopIds: ["Berkat", "GRGZ"], stops: [
        Stop(id: UUID(), name: "Berkat", latitude: 0, longitude: 0, adres: "", busIds: [""]),
        Stop(id: UUID(), name: "Tashkala", latitude: 0, longitude: 0, adres: "", busIds: [""])
    ]))
}
