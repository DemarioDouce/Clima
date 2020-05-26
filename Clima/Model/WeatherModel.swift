//
//  WeatherModel.swift
//  Clima
//
//  Created by Demario Douce on 2020-05-26.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    let weatherID: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        
        return String(format: "%.0f", temperature)
    }
    
    var conditionName: String {
        //Cases from https://openweathermap.org/weather-conditions
        switch weatherID {
            
        case 200...232:
            return "cloud.bolt"
            
        case 300...321:
            return "cloud.drizzle"
            
        case 500...531:
            return "cloud.rain"
            
        case 600...622:
            return "cloud.snow"
            
        case 701...781:
            return "cloud.fog"
            
        case 800:
            return "sun.max"
            
        case 801...804:
            return "cloud.bolt"
            
        default:
            return "cloud"
        }
    }
    
    
}
