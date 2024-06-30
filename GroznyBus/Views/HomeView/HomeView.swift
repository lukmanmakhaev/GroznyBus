//
//  HomeView.swift
//  GroznyBus
//
//  Created by Lukman Makhaev on 22.06.2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var adminViewModel: AdminViewModel
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                CustomNavBar()
                    .environmentObject(homeViewModel)
                    .environmentObject(adminViewModel)
                
                ScrollView {
                    
                    HomeCardView()
                    
                    HStack {
                        Text("Остановки рядом")
                            .font(.system(size: 22))
                            .fontWeight(.medium)
                        Spacer()
                    }
                    .padding(.top, 37)
                    .padding(.horizontal, 28)
                    
                    ForEach(homeViewModel.stops) { stop in
                       
                    
                        
                    }
                    
                    
                    
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
                            ForEach(homeViewModel.buses) { bus in

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
                                        .frame(width: 150, height: 190)
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
                                    
                                    Text("Oстановок: \(bus.stopIds?.count ?? 0)")
                                        .font(.system(size: 14))
                                        .fontWeight(.light)
                                        .padding(.leading, 10)
                                        
                                }
                            }
                        }
                        .padding(.horizontal, 28)
                        
                    }
                    .padding(.top, 28)
                    
                }
            }
            .background(Color("bgColor"))
        }
        
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
        .environmentObject(AdminViewModel())
}


struct HomeCardView: View {
    
    var body: some View {
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
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 140)
        .background(Color.accentColor)
        .cornerRadius(30)
        .padding(.horizontal, 28)
        .padding(.top, 12)
    }
}

struct CustomNavBar: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var adminViewModel: AdminViewModel
    
    var body: some View {
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
                .onTapGesture {
                    homeViewModel.tapCount += 1
                    if homeViewModel.tapCount == 10 {
                        homeViewModel.showAdminView.toggle()
                        homeViewModel.tapCount = 0
                    }
                }
                .fullScreenCover(isPresented: $homeViewModel.showAdminView) {
                    AdminView()
                        .environmentObject(adminViewModel)
                        .environmentObject(homeViewModel)
                }
            
            Spacer()
            
            Button(action: {
                homeViewModel.saveAllStops(homeViewModel.stopss)
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
    }
}
