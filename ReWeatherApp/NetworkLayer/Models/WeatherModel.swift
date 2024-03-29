//
//  WeatherModel.swift
//  ReWeatherApp
//
//  Created by Alikhan Tursunbekov on 29/3/24.
//

import Foundation

struct WeatherModel: Codable {
    let hourly: [HourlyModel]
    let daily: [DailyModel]
}

struct HourlyModel: Codable {
    let dt: Int
    let temp: Double
    let weather: [WeatherImageModel]
}

struct DailyModel: Codable {
    let dt: Int
    let temp: TempModel
    let weather: [WeatherImageModel]
}

struct TempModel: Codable {
    let day: Double
}

struct WeatherImageModel: Codable {
    let main: String
    let icon: String
}
