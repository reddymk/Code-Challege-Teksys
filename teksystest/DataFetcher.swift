//
//  DataFetcher.swift
//  teksystest
//
//  Created by Manish Reddy on 6/8/17.
//  Copyright © 2017 Manish. All rights reserved.
//

import Foundation
import Alamofire

final class WeatherDataFetcher: WeatherDataFetchable {
    
    func fetchWeatherData(_ cityText: String, completed: @escaping (TemperatureData) -> Void) {
        FetchData.getWeatherData(city: cityText) { response in
            let temperatureData = DisplayedData.processWeatherdataFromJson(response)
            completed(temperatureData)
        }
    }
}

struct FetchData {
    
    static func getWeatherData(city: String, completion: @escaping (NSDictionary) -> Void) {
        
        let key = "appid=b1da240c8025708cdefbce9d6a8406e3"
    
        let url = "http://api.openweathermap.org/data/2.5/forecast/daily?cnt=3&units=imperial&" + key + "&q=" + city
        
        Alamofire.request(url).responseJSON { response in
     
            switch response.result {
                case .success:
                    completion(response.result.value as! NSDictionary)
                case .failure:
                    break
            }
        }
    }
}
