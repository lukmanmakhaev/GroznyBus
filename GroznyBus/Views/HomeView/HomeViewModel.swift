//
//  HomeViewModel.swift
//  GroznyBus
//
//  Created by Lukman Makhaev on 23.06.2024.
//

import Foundation
import FirebaseFirestore


class HomeViewModel: ObservableObject {
    
    @Published var stops: [Stop] = []
    @Published var buses: [Bus] = []
    
    @Published var tapCount: Int = 0
    @Published var showAdminView =  false
    
    private let db = Firestore.firestore()
    
    init() {
        
        Task {
            await loadStops()
            await loadBuses()
        }
    }
    @MainActor
    func loadStops() {
        db.collection("stops").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting stops: \(error.localizedDescription)")
                return
            }
            
            self.stops = querySnapshot?.documents.compactMap { document -> Stop? in
                let data = document.data()
                //print("stops successfully loaded")
                return Stop(dictionary: data)
            } ?? []
        }
    }
    
    func loadStop(byID id: String) async throws -> Stop? {
        let docRef = db.collection("stops").document(id)
        
        do {
            let document = try await docRef.getDocument()
            
            guard let data = document.data() else {
                print("Stop not found")
                return nil
            }
            
            let stop = Stop(dictionary: data)
            //print("Stop successfully loaded")
            return stop
        } catch {
            print("Error getting stop: \(error.localizedDescription)")
            throw error
        }
    }
    
    @MainActor
    func loadBuses() async {
        do {
            let querySnapshot = try await db.collection("buses").getDocuments()
            var buses: [Bus] = []
            
            for document in querySnapshot.documents {
                let data = document.data()
                guard var bus = Bus(dictionary: data) else {
                    continue
                }
                
                var stops: [Stop] = []
                
                guard let stopIds = bus.stopIds else {
                    return
                }
                
                for stopId in stopIds {
                    if let stop = try? await loadStop(byID: stopId) {
                        stops.append(stop)
                    } else {
                        stops.append(Stop(id: UUID(), name: "", latitude: 0, longitude: 0, adres: "", busIds: []))
                    }
                }
                bus.stops = stops
                buses.append(bus)
            }
            
            self.buses = buses
            print("Buses successfully loaded")
            
        } catch {
            print("Error getting buses: \(error.localizedDescription)")
        }
    }
    
    func saveStop(_ stop: Stop) {
        db.collection("stops").document(stop.id.uuidString).setData(stop.toDictionary()) { error in
            if let error = error {
                print("Error saving stop: \(error.localizedDescription)")
            } else {
                print("Stop saved successfully")
            }
        }
    }
    
    func saveBus(_ bus: Bus) {
        db.collection("buses").document(bus.id.uuidString).setData(bus.toDictionary()) { error in
            if let error = error {
                print("Error saving bus: \(error.localizedDescription)")
            } else {
                print("Bus saved successfully")
            }
        }
    }
    
    
//
//     var stopss = [
//        //
//        Stop(id: UUID(), name: "ТЦ Беркат", latitude: 43.33071, longitude: 45.68444, adres: "улица Нурсултана Абишевича Назарбаева", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "Автобаза", latitude:  43.32937, longitude: 45.68136, adres: "Старопромысловское ш., 38, Грозный", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "12-й трест", latitude: 43.33425, longitude: 45.67301, adres: "Старопромысловское ш., 38, Грозный", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "ГРМЗ", latitude: 43.33589, longitude: 45.67016, adres: "Старопромысловское ш., 38, Грозный", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "Горгаз", latitude: 43.33928, longitude: 45.66433, adres: "Старопромысловское ш., 38, Грозный", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "Нефтянка", latitude: 43.34018, longitude: 45.66282, adres: "улица Вахи Алиева", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "Березка", latitude: 43.34387, longitude: 45.65637, adres: "улица Вахи Алиева", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "Магазин", latitude: 43.34529, longitude: 45.65341, adres: "улица Вахи Алиева", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "Почта 59", latitude: 43.34676, longitude: 45.64981, adres: "улица Вахи Алиева", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "Ташкала", latitude: 43.34929, longitude: 45.64475, adres: "улица Вахи Алиева", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "Начало Катаямы", latitude: 43.35207, longitude: 45.63930, adres: "улица Вахи Алиева", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "Детская к. больница", latitude: 43.35357, longitude: 45.63631, adres: "улица Вахи Алиева", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "ул Школьная", latitude: 43.35524, longitude: 45.63302, adres: "улица Вахи Алиева", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "Советский переулок", latitude: 43.35822, longitude: 45.62713, adres: "ул. Вахи Алиева, 65, Грозный", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "Катаяма", latitude: 43.36173, longitude: 45.62022, adres: "ул. Вахи Алиева, 15/2, Грозный", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "ТЦ Нефтяник", latitude: 43.36519, longitude: 45.61268, adres: "улица Вахи Алиева", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "Иванова 1", latitude: 43.36687, longitude: 45.60857, adres: "улица Вахи Алиева", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "Иванова 2", latitude: 43.36963, longitude: 45.60189, adres: "улица Вахи Алиева", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "Детский сад", latitude: 43.37153, longitude: 45.59723, adres: "улица Вахи Алиева", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "Автотрест", latitude: 43.37322, longitude: 45.59282, adres: "улица Вахи Алиева", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "Бутенко", latitude: 43.37422, longitude: 45.5880, adres: "улица Вахи Алиева", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "Поворот на 60 лет Октября", latitude: 43.37527, longitude: 45.58484, adres: "Кутаисская улица", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "Пролетарская", latitude: 43.38832, longitude: 45.58908, adres: "село Пролетарское, улица А.Х. Кадырова", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "Школа", latitude: 43.40819, longitude: 45.59153, adres: "село Садовое, Черкасская улица", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        Stop(id: UUID(), name: "Садовое", latitude: 43.40886, longitude: 45.59772, adres: "село Садовое, Черкасская улица", busIds: ["EDE38719-0A99-4389-AE0B-93CD60B47CCF", "EDE38719-0A99-4389-AE0B-93CD60B47CCR"]),
//        
//        //
//    ]
    
    func saveAllStops(_ stops: [Stop]) {
        for stop in stops {
            saveStop(stop)
        }
    }
    
//
//    let busses = [
//        Bus(id: UUID(), name: "103", route: [Stop(id: UUID(), name: "Новая остановка"), Stop(id: UUID(), name: "Бутенко")]),
//        Bus(id: UUID(), name: "36", route: [Stop(id: UUID(), name: "Новая остановка"), Stop(id: UUID(), name: "Бутенко")]),
//        Bus(id: UUID(), name: "4", route: [Stop(id: UUID(), name: "Бутенко"), Stop(id: UUID(), name: "Ташкала")]),
//        Bus(id: UUID(), name: "4А", route: [Stop(id: UUID(), name: "Бутенко"), Stop(id: UUID(), name: "Иваново")])
//    ]
    
    
}
