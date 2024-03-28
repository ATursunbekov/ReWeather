//
//  API.swift
//  ReWeatherApp
//
//  Created by Alikhan Tursunbekov on 29/3/24.
//

import Moya
import Foundation

enum API {
    case getWeather(lat: Double, lon: Double, exclude: [String], appid: String, units: String)
}

extension API: TargetType {
    var baseURL: URL {
        switch self {
        case .getWeather:
            return URL(string: "https://api.openweathermap.org/data/3.0")!
        }
    }
    
    var path: String {
        switch self {
        case .getWeather:
            return "/onecall"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getWeather:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getWeather(let lat, let lon, let exclude, let appid, let units):
            return .requestParameters(parameters: ["lat": lat, "lon": lon, "exclude": exclude.joined(separator: ","), "appid": appid, "units": units], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
