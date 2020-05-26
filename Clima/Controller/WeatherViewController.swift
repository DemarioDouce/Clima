//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
    
    //UI Elements
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTbx: UITextField!
    
    //Create object
    var weatherManagerML = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Boss --> employee giving power to it
        searchTbx.delegate = self
        
    }
    
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

