//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by EricDev on 5/15/17.
//  Copyright © 2017 EricDev. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    let initialAuthorization = CLLocationManager.authorizationStatus()
    
    var currentWeather: CurrentWeather!
    var weather: [Weathers]!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        weather = [Weathers]()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthenticationStatus()
    }
    
    func locationAuthenticationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
        
            self.currentWeather.downloadWeatherDetails {
                    
                self.updateMainUI()
                    
            }
            
            loadForecast(){
                
                self.tableView.reloadData()
            
            }
        } else if CLLocationManager.authorizationStatus() == .denied {
            if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.open(url as URL)
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != initialAuthorization {
            locationAuthenticationStatus()
        }
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherCell
        let weatherObject = weather[indexPath.row]
        cell.loadCell(weatherObject: weatherObject)
        
        return cell
    }
    
    
    func loadForecast(completed: @escaping DownloadComplete) {
        let forecastURL = URL(string: FORECAST_URL)!
        Alamofire.request(forecastURL).responseJSON { response in
            let result = response.result
            if let weatherDictionary = result.value as? Dictionary<String, AnyObject> {
                if let list = weatherDictionary["list"] as? [Dictionary<String, AnyObject>] {
                    for weather in list {
                        self.weather.append(Weathers(weatherItem: weather))
                    }
                }
            }
            self.weather.remove(at: 0)
        completed()
        }
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        weatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        tempLabel.text = "\(currentWeather.currentTemp)°"
        weatherImage.image = UIImage(named: currentWeather.weatherType)
    }

}

