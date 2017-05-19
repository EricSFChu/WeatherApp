//
//  Constants.swift
//  WeatherApp
//
//  Created by EricDev on 5/15/17.
//  Copyright © 2017 EricDev. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/"
let WEATHER = "weather?"
let FORECAST = "forecast/daily?"
let LONGITUDE = "lon="
let LATITUDE = "&lat="
let APP_ID = "&appid="
let API_KEY = "d2651961446656ae6019726d93538ed1"

typealias DownloadComplete = () -> ()

let CURRENT_URL = "\(BASE_URL)\(WEATHER)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(LATITUDE)\(Location.sharedInstance.latitude!)\(APP_ID)\(API_KEY)"
let FORECAST_URL = "\(BASE_URL)\(FORECAST)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(LATITUDE)\(Location.sharedInstance.latitude!)\(APP_ID)\(API_KEY)"
