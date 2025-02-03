//
//  WeatherMenager.swift
//  Clima
//
//  Created by Patryk Danielewicz on 07/03/2024.
// 
//

import Foundation
import CoreLocation

protocol WeatherMenagerDelegate {
    func didUpdateWeather(_ weatherMenager: WeatherMenager, weather: WeatherModel)
    func didFailWithError(error: Error)
}





struct WeatherMenager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=dff4d48c4b67a315045607d7dca7e2df"
    
    var delegate: WeatherMenagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        preformRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        preformRequest(with: urlString)
    }
    func preformRequest(with urlString: String) {
      
        // 1. Create URL
        
        if let url = URL(string: urlString) {
            
            
            
            //2. Create a URL Session
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeDate = data {
                    if let weather = self.parseJSNO(safeDate) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                        
                    }
                    
                }
            }
            
            // 4. Start the tash
            
            task.resume()
            
        }
        
    }
    
    
    func parseJSNO(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            
         let decodedData =  try  decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
                 }
        
        catch {
            delegate?.didFailWithError(error: error)
            return nil
        
        }
    }
    
    
    
}

