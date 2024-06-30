//
//  StopItemView.swift
//  GroznyBus
//
//  Created by Lukman Makhaev on 30.06.2024.
//

import SwiftUI

struct StopItemView: View {
    var stop: Stop
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .foregroundColor(.colorGray2)
                
                Image(systemName: "mappin")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .padding(12)
                    .foregroundColor(.colorGray3)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
            .frame(width: 50, height: 50)
            
            VStack (alignment: .leading, spacing: 4) {
                
                
                Text("\(stop.name)")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                
                Text("\(stop.adres)")
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .lineLimit(1, reservesSpace: false)
                
            }
            .padding(.leading, 8)

            
            Spacer()
            
            VStack {
                Text("")
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
    StopItemView(stop: Stop(id: UUID(), name: "Berkat", latitude: 0, longitude: 0, adres: "Старопромысловское ш.", busIds: ["berkat", "tashkala"]))
}
