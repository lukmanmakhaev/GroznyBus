//
//  HomeView.swift
//  GroznyBus
//
//  Created by Lukman Makhaev on 22.06.2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        
        VStack {
            HStack {
                Button(action: {
                    
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .aspectRatio(contentMode: .fill)
                })
                
                Spacer()
                
                Text("GroznyBus")
                    .font(.system(size: 19))
                    .fontWeight(.heavy)
                    .lineLimit(2)
                    .foregroundStyle(.accent)
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "line.3.horizontal.circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .aspectRatio(contentMode: .fill)
                })
                
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 12)
            .foregroundColor(.colorGray)
            
            ScrollView {
                
                HStack {
                    
                    VStack (alignment: .leading, spacing: 8) {
                        
                        Text("Новое")
                            .font(.system(size: 10))
                            .fontWeight(.medium)
                        
                        Text("103-й теперь в GroznyBus")
                            .font(.system(size: 19))
                            .fontWeight(.bold)
                            .lineLimit(2)
                        
                        Text("с. Садовое")
                            .font(.system(size: 13))
                            .fontWeight(.medium)
                        
                        
                    }
                    .padding(19)
                    .foregroundStyle(.white)
                    
                    Spacer()
                
                    VStack (alignment: .trailing) {
                        Image("bus")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 155)
                            .padding(.trailing, -20)
                            //.padding(.top, 5)
                    }
                }
                //.padding(16)
                .frame(maxWidth: .infinity)
                .frame(height: 140)
                .background(Color.accentColor)
                .cornerRadius(30)
                .padding(.horizontal, 28)
                .padding(.top, 12)
                
                HStack {
                    Text("Автобусы")
                        .font(.system(size: 22))
                        .fontWeight(.medium)
                    Spacer()
                }
                .padding(.top, 41)
                .padding(.horizontal, 28)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack (spacing: 14){
                        ForEach(homeViewModel.busses) { bus in

                            VStack (alignment: .leading, spacing: 3){
                                Button(action: {
                                    
                                }, label: {
                                    VStack {
                                        Text(bus.name)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .font(.system(size: 40))
                                            .foregroundColor(.white)
                                            .fontWeight(.bold)
                                            .shadow(color: Color.white, radius: 15, x: 0, y: 0)
                                        
                                        Image("bus")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 100)
                                            .shadow(color: Color.black, radius: 30, x: 0, y: 0)
                                    }
                                    .padding(14)
                                    .frame(width: 140, height: 190)
                                    .background(
                                        Image("map2")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .blur(radius: 1.0)
                                        
                                    )
                                    .cornerRadius(30)
                            })
                                
                                Text("Автобус №\(bus.name)")
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .padding(.top, 10)
                                    .padding(.leading, 10)
                                
                                Text("Oстановок: \(bus.route.count)")
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                                    .padding(.leading, 10)
                                    
                            }
                        }
                    }
                    .padding(.horizontal, 28)
                    
                    HStack {
                        Text("Остановки")
                            .font(.system(size: 22))
                            .fontWeight(.medium)
                        Spacer()
                    }
                    .padding(.top, 37)
                    .padding(.horizontal, 28)
                }
                .padding(.top, 28)
            }
        }
        .background(Color("bgColor"))
        
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
