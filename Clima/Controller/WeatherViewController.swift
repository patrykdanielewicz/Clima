//
//  ViewController.swift
//  Clima
//
//   Created by Patryk Danielewicz on 10/03/2024.
//
//

import UIKit
import CoreLocation
class WeatherViewController: UIViewController  {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var serchTextField: UITextField!
     
    var weatherMenager = WeatherMenager()
    let locationMenager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationMenager.requestWhenInUseAuthorization()
        locationMenager.delegate = self
        locationMenager.requestLocation()
        weatherMenager.delegate = self
        serchTextField.delegate = self
        
    }

    
    @IBAction func LocationButton(_ sender: UIButton) {
        locationMenager.requestLocation()
    }
    
    

    
}

//MARK: - UITextFieldDelegate


extension WeatherViewController: UITextFieldDelegate {
    @IBAction func serchPressed(_ sender: UIButton) {
    
        serchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        serchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = serchTextField.text {
            weatherMenager.fetchWeather(cityName: city)
        }
        serchTextField.text = ""
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        else {
            textField.placeholder = "Wpisz miasto"
            return false
        }
    }
    
   
    
    
}

// MARK: - WeatherMenagerDelegate


extension WeatherViewController: WeatherMenagerDelegate {
   
    func didUpdateWeather(_ weatherMenager: WeatherMenager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
       
    }
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

//MARK: - CLLocationMenagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationMenager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherMenager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
 
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}
