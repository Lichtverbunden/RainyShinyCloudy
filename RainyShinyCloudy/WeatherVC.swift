//
//  WeatherVC.swift
//  RainyShinyCloudy
//
//  Created by Ken Krippeler on 06.07.17.
//  Copyright © 2017 Lichtverbunden. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate
{
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        currentWeather = CurrentWeather()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus()
    {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse
        {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            currentWeather.downloadWeatherDetails
            {
                self.downloadForecastData
                {
                    //Setup UI to load downloaded data
                    self.updateMainUI()
                }
            }

        }
        else
        {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete)
    {
        //Downloading forecast weather data for TableView
        let forecastURL = URL(string: FORECAST_URL)!
        Alamofire.request(forecastURL).responseJSON
        { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, Any>
            {
                if let list = dict["list"] as? [Dictionary<String, Any>]
                {
                    for obj in list
                    {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell
        {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        }
        else
        {
            return WeatherCell()
        }
    }
    
    func updateMainUI()
    {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)°"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }

}

