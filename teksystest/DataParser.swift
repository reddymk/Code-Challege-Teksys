//
//  DataParser.swift
//  teksystest
//
//  Created by Manish Reddy on 6/8/17.
//  Copyright © 2017 Manish. All rights reserved.
//

import Foundation

struct TemperatureFor3Days {
    let minimumTemperature: Double
    let maximumTemperature: Double
    let description: String
    let dateString: String
}

struct TemperatureData {
    let city: String
    let country: String
    let temperatureFor3Days: [TemperatureFor3Days]
}

struct DisplayedData {
    
    // Json Parser
    static func processWeatherdataFromJson(_ json: NSDictionary) -> TemperatureData {
        
        var country = ""
        var city = ""
        var temperatureFor3Days = [TemperatureFor3Days]()
        
        if let cityDictionary = json["city"] as? NSDictionary {
            if let cityName = cityDictionary["name"] as? String, let countryString = cityDictionary["country"] as? String {
                city = cityName
                country = countryString
            }
        }
        
        if let arrayList = json["list"] as? NSArray {
            
            for index in 0..<arrayList.count {
                
                var dateString = ""
                var minTemp = 0.0
                var maxTemp = 0.0
                var description = ""
                
                let list = arrayList[index] as! NSDictionary
                
                if let dates = list["dt"] as? Double {
                    dateString = convertDates(date: dates)
                }

            if let temperatures = list["temp"] as? NSDictionary {
                    if let min = temperatures["min"] as? Double, let max = temperatures["max"] as? Double {
                        minTemp = min
                        maxTemp = max
                    }
                }
                
            if let weather = list["weather"] as? NSArray {
                if let array1 = weather[0] as? NSDictionary {
                    if let des = array1["description"] as? String {
                        description = des
                    }
                }
            }
            temperatureFor3Days.append(TemperatureFor3Days(minimumTemperature: minTemp, maximumTemperature: maxTemp, description: description, dateString: dateString))
            }
        }
        
        return TemperatureData(city: city, country: country, temperatureFor3Days: temperatureFor3Days)
    }

    // Convert date stamp to date.
    static func convertDates(date: Double) -> String {
        
        let date = NSDate(timeIntervalSince1970: date)
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM dd YYYY"
        
        return dayTimePeriodFormatter.string(from: date as Date)
    }
}
