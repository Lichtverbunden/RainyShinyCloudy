//
//  currentWeather.swift
//  RainyShinyCloudy
//
//  Created by Ken Krippeler on 07.07.17.
//  Copyright © 2017 Lichtverbunden. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather
{
    fileprivate var _cityName: String!
    fileprivate var _date: String!
    fileprivate var _weatherType: String!
    fileprivate var _currentTemp: Int!
//    fileprivate var _highTemp: Int!
//    fileprivate var _lowTemp: Int!
    
    var cityName: String
    {
        if _cityName == nil
        {
            _cityName = ""
        }
        
        return _cityName
    }
    var weatherType: String
    {
        if _weatherType == nil
        {
            _weatherType = ""
        }
        
        return _weatherType
    }
    var currentTemp: Int
    {
        if _currentTemp == nil
        {
            _currentTemp = 0
        }
        
        return _currentTemp
    }
//    var highTemp: Int
//    {
//        if _highTemp == nil
//        {
//            _highTemp = 0
//        }
//        
//        return _highTemp
//    }
//    var lowTemp: Int
//    {
//        if _lowTemp == nil
//        {
//            _lowTemp = 0
//        }
//        
//        return _lowTemp
//    }
    
    var date: String
    {
        if _date == nil
        {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete)
    {
        //Alamofire download
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        
        Alamofire.request(currentWeatherURL).responseJSON
        {
            response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, Any>
            {
                if let name = dict["name"] as? String
                {
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
                
                if let weather = dict["weather"] as? [Dictionary<String,Any>]
                {
                    if let main = weather[0]["main"] as? String
                    {
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, Any>
                {
                    if let currentTemperature = main["temp"] as? Double
                    {
                        let kelvinToCelsius = Int(round(currentTemperature - 273.15))
                        self._currentTemp = kelvinToCelsius
                        print(self._currentTemp)
                    }
                }
                
//                if let main = dict["main"] as? Dictionary<String, Any>
//                {
//                    if let lowTemperature = main["temp_min"] as? Double
//                    {
//                        let kelvinToCelsius = Int(round(lowTemperature - 273.15))
//                        self._lowTemp = kelvinToCelsius
//                        print(self._lowTemp)
//                    }
//                }
//                
//                if let main = dict["main"] as? Dictionary<String, Any>
//                {
//                    if let highTemperature = main["temp_max"] as? Double
//                    {
//                        let kelvinToCelsius = Int(round(highTemperature - 273.15))
//                        self._highTemp = kelvinToCelsius
//                        print(self._highTemp)
//                    }
//                }
                
                
            }
            completed()
        }
        
    }

}
