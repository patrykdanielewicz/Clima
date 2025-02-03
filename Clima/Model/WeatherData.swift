//
//  WeatherData.swift
//  Clima
//
//  Created by Patryk Danielewicz on 09/03/2024.
// 
//

import Foundation
struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}
struct Main: Decodable {
let temp: Double
}
struct Weather: Decodable {
    let description: String
    let id: Int
}


