//
//  API.swift
//  ReWeatherApp
//
//  Created by Alikhan Tursunbekov on 29/3/24.

import Foundation
import Moya

enum API {
    case getLocation(cityName: String)
    case getWeather(lat: Double, lon: Double)
}

extension API: TargetType {
    var baseURL: URL {
        switch self {
        case .getLocation:
            return URL(string: "https://api.openweathermap.org/geo/1.0")!
        case .getWeather:
            return URL(string: "https://api.openweathermap.org/data/3.0")!
        }
    }
    
    var path: String {
        switch self {
        case .getLocation:
            return "/direct"
        case .getWeather:
            return "/onecall"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getWeather, .getLocation:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getLocation(let cityName):
            return .requestParameters(parameters: ["q": cityName, "appid": DataManager.appID], encoding: URLEncoding.queryString)
        case .getWeather(let lat, let lon):
            return .requestParameters(parameters: ["lat": lat, "lon": lon, "exclude": "minutely,alerts", "appid": DataManager.appID, "units": "metric"], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
