//
//  ViewModel.swift
//  teksystest
//
//  Created by Manish Reddy on 6/8/17.
//  Copyright © 2017 Manish. All rights reserved.
//

import Foundation

protocol ViewControllerDelegate: class {
    func reloadData()
}

protocol WeatherDataFetchable {
    
    func fetchWeatherData(_ cityText: String, completed: @escaping (TemperatureData) -> Void)
    
}

class ViewModel {
    
    var temperatureData: TemperatureData?
    fileprivate let weatherDataFetcher: WeatherDataFetchable
    
    weak var delegate: ViewControllerDelegate?
    
    init(weatherDataFetcher: WeatherDataFetchable) {
        self.weatherDataFetcher = weatherDataFetcher
    }


    func fetchWeatherData(cityText: String) {
        weatherDataFetcher.fetchWeatherData(cityText) { temperatureData in
            self.temperatureData = temperatureData
            self.delegate?.reloadData()
        }

    }
}
