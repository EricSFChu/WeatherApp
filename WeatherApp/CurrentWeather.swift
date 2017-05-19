//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by EricDev on 5/15/17.
//  Copyright © 2017 EricDev. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    var _highTemp: Double!
    var _lowTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    var highTemp: Double {
        if _highTemp == nil {
            _highTemp = 0.0
        }
        return _highTemp
    }
    
    var lowTemp: Double {
        if _lowTemp == nil {
            _lowTemp = 0.0
        }
        return _lowTemp
    }
    
    func downloadWeatherDetails(completed: DownloadComplete) {
        //Use Alamofire to download JSON
        let currentWeatherURL = URL(string: CURRENT_URL)!
        Alamofire.request(currentWeatherURL).responseJSON { response in
            let result = response.result
            if let weatherDictionary = result.value as? Dictionary<String, AnyObject> {
                if let name = weatherDictionary["name"] as? String {
                    self._cityName = name.capitalized
                }
                
                if let weather = weatherDictionary["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                    }
                }
                
                if let currentTemp = weatherDictionary["main"]?["temp"] as? Double {
                    self._currentTemp = round(10*(1.8*(currentTemp-273)+32)/10)
                }
            }
        }
        completed()
    }
}
