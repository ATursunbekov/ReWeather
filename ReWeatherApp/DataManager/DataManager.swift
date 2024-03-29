//
//  DataManager.swift
//  ReWeatherApp
//
//  Created by Alikhan Tursunbekov on 29/3/24.
//

import Foundation

class DataManager {
    static var shared = DataManager()
    static var appID = "ac3a0f285476c882206a323471fc35ac"
    
    var cities: [String] = []
    
    private init() {}
    
    func refreshData() {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(cities) {
            UserDefaults.standard.set(encoded, forKey: "cities")
        }
    }
    
    func addCityHistory(city: String) {
        if cities.count > 5 {
            cities.removeLast()
        }
        cities.insert(city, at: 0)
        refreshData()
    }
    
    func getAmount() -> Int{
        return cities.count
    }
    
    func getCity(index: Int) -> String {
        return cities[index]
    }
}
