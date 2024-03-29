//
//  MainViewModel.swift
//  ReWeatherApp
//
//  Created by Alikhan Tursunbekov on 29/3/24.
//

import Foundation

protocol MainViewModelDelegate {
    func refreshData(data: WeatherModel)
}

protocol MainViewModelProtocol {
    var delegate: MainViewModelDelegate? {get set}
    var weekWeather: [DailyModel] {get set}
    var hourlyWeather: [HourlyModel] {get set}
    func getLocation(cityName: String)
    func getForcast(location: LocationModel)
}

class MainViewModel: MainViewModelProtocol {
    var delegate: MainViewModelDelegate?
    var weekWeather: [DailyModel] = []
    var hourlyWeather: [HourlyModel] = []
    
    func getLocation(cityName: String) {
        NetworkService.shared.sendRequest(successModelType: [LocationModel].self, endpoint: MultiTarget(API.getLocation(cityName: cityName))) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                print("Successful response!")
                if let check = response.first {
                    getForcast(location: check)
                }
            case .failure(let error):
                print("handle error: \(error)")
            }
        }
    }
    
    func getForcast(location: LocationModel) {
        NetworkService.shared.sendRequest(successModelType: WeatherModel.self, endpoint: MultiTarget(API.getWeather(lat: location.lat, lon: location.lon))) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                weekWeather = response.daily
                hourlyWeather = response.hourly
                delegate?.refreshData(data: response)
            case .failure(let error):
                print("handle error: \(error)")
            }
        }
    }
}
