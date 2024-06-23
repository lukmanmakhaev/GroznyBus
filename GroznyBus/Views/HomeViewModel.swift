//
//  HomeViewModel.swift
//  GroznyBus
//
//  Created by Lukman Makhaev on 23.06.2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var stops = [
        Stop(id: UUID(), name: "ТЦ Беркат"),
        Stop(id: UUID(), name: "Автобаза"),
        Stop(id: UUID(), name: "12-й трест"),
        Stop(id: UUID(), name: "ГРМЗ"),
        Stop(id: UUID(), name: "Нефтянка"),
        Stop(id: UUID(), name: "Березка"),
        Stop(id: UUID(), name: "Магазин"),
        Stop(id: UUID(), name: "Почта 59"),
        Stop(id: UUID(), name: "Ташкала"),
        Stop(id: UUID(), name: "Детская к. больница"),
        Stop(id: UUID(), name: "Начало Катаямы"),
        Stop(id: UUID(), name: "ул Школьная"),
        Stop(id: UUID(), name: "Советский переулок"),
        Stop(id: UUID(), name: "Катаяма"),
        Stop(id: UUID(), name: "ТЦ Нефтяник"),
        Stop(id: UUID(), name: "Иванова 1"),
        Stop(id: UUID(), name: "Иванова 2"),
        Stop(id: UUID(), name: "Детский сад"),
        Stop(id: UUID(), name: "Автотрест"),
        Stop(id: UUID(), name: "Бутенко"),
        Stop(id: UUID(), name: "Пролетарская"),
        Stop(id: UUID(), name: "Садовое"),
        Stop(id: UUID(), name: "2-е отделение"),
        Stop(id: UUID(), name: "Совхоз 60 лет октября"),
    ]
    
    let busses = [
        Bus(id: UUID(), name: "103", route: [Stop(id: UUID(), name: "Новая остановка"), Stop(id: UUID(), name: "Бутенко")]),
        Bus(id: UUID(), name: "36", route: [Stop(id: UUID(), name: "Новая остановка"), Stop(id: UUID(), name: "Бутенко")]),
        Bus(id: UUID(), name: "4", route: [Stop(id: UUID(), name: "Бутенко"), Stop(id: UUID(), name: "Ташкала")]),
        Bus(id: UUID(), name: "4А", route: [Stop(id: UUID(), name: "Бутенко"), Stop(id: UUID(), name: "Иваново")])
    ]
    
    
}
