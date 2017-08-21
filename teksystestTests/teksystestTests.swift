//
//  teksystestTests.swift
//  teksystestTests
//
//  Created by Manish Reddy on 6/7/17.
//  Copyright © 2017 Manish. All rights reserved.
//

import XCTest
@testable import teksystest

class teksystestTests: XCTestCase {
    
    var viewModel: ViewModel!
    fileprivate var weatherDataMock: WeatherDataMockFetcher!
    
    override func setUp() {
        super.setUp()
        
        weatherDataMock = WeatherDataMockFetcher()
        viewModel = ViewModel(weatherDataFetcher: weatherDataMock)
    }
    
    
    func test_viewModel() {
        
        viewModel.fetchWeatherData(cityText: "phoenix")
        let expectation = self.expectation(description: "async_test")
        let temperatureFor3Days = [TemperatureFor3Days(minimumTemperature: 70.0, maximumTemperature: 100.0, description: "Clear", dateString: "7 June, 2017"),
                                   TemperatureFor3Days(minimumTemperature: 50.0, maximumTemperature: 101.0, description: "Cloudy", dateString: "8 June, 2017"),
                                   TemperatureFor3Days(minimumTemperature: 20.0, maximumTemperature: 80.0, description: "Rain", dateString: "8 June, 2017")]

        DispatchQueue.main.async {
            
            XCTAssertNotNil(self.viewModel.temperatureData)
            XCTAssertEqual(self.viewModel.temperatureData?.city, "phoenix")
            XCTAssertEqual(self.viewModel.temperatureData?.country, "")
            XCTAssertEqual(self.viewModel.temperatureData!.temperatureFor3Days[0].dateString, temperatureFor3Days[0].dateString)
            XCTAssertEqual(self.viewModel.temperatureData!.temperatureFor3Days[0].minimumTemperature, temperatureFor3Days[0].minimumTemperature)
            XCTAssertEqual(self.viewModel.temperatureData!.temperatureFor3Days[0].maximumTemperature, temperatureFor3Days[0].maximumTemperature)
            XCTAssertEqual(self.viewModel.temperatureData!.temperatureFor3Days[0].description, temperatureFor3Days[0].description)

            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}

// Mock Fetcher
class WeatherDataMockFetcher: WeatherDataFetchable {
    
    func fetchWeatherData(_ cityText: String, completed: @escaping (TemperatureData) -> Void) {
       let temperatureFor3Days = [TemperatureFor3Days(minimumTemperature: 70.0, maximumTemperature: 100.0, description: "Clear", dateString: "7 June, 2017"),
                                  TemperatureFor3Days(minimumTemperature: 50.0, maximumTemperature: 101.0, description: "Cloudy", dateString: "8 June, 2017"),
                                  TemperatureFor3Days(minimumTemperature: 20.0, maximumTemperature: 80.0, description: "Rain", dateString: "8 June, 2017")]
        
        let temperatureData = TemperatureData(city: cityText, country: "", temperatureFor3Days: temperatureFor3Days)
    
        completed(temperatureData)
    }

}
    
    

