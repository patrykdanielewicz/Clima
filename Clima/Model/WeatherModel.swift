//
//  WeatherModel.swift
//  Clima
//
//  Created by Patryk Danielewicz on 10/03/2024.
// 
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
       return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 800:
            return "sun.max"
        default:
            return "cloud"
        }
    }
    
    
       
    
}




