//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

//MARK: - Main

class WeatherViewController: UIViewController {
    
    
    
    //UI Elements
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTbx: UITextField!
    @IBOutlet weak var locationPressed: UIButton!
    
    //Create object
    var weatherManagerML = WeatherManager()
    var locationManager =  CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Location object
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        //Boss --> employee giving power to it
        searchTbx.delegate = self
        weatherManagerML.delegate = self
        
    }
    
    @IBAction func locaPressedBtn(_ sender: UIButton) {
       
        locationManager.requestLocation()
    }
}


//MARK: - UITextFieldDelegate


extension WeatherViewController: UITextFieldDelegate{
    
    //Func for search icon btn
    @IBAction func searchBtnClick(_ sender: UIButton) {
        
        //Dissmiss keyboard
        searchTbx.endEditing(true)
        
    }
    
    //Func for if the go button is click.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Dissmiss keyboard
        searchTbx.endEditing(true)
        
        print(searchTbx.text!)
        
        return true
    }
    
    //Tells the delegate that editing stopped for the specified text field.
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Use searchTbx.text to get the weather for the city
        let city = searchTbx.text ?? ""
        
        //pass the value to the method in weather manager model
        weatherManagerML.getWeather(cityName: city)
        
        //Clear text
        searchTbx.text = ""
    }
    
    //Validation of what the user type
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField.text != ""{
            return true
        } else {
            
            textField.placeholder = "Type something"
            return false
        }
    }
    
    
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate{
    
    func didUpdateweather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        
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


//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            weatherManagerML.getWeather(latitude: lat, longitude: lon)
            
           
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    
        print(error)
        
    }
    
    
    
}
