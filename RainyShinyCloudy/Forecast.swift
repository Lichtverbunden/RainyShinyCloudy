//
//  Forecast.swift
//  RainyShinyCloudy
//
//  Created by Ken Krippeler on 10.07.17.
//  Copyright © 2017 Lichtverbunden. All rights reserved.
//

import UIKit
import Alamofire

class Forecast
{
    fileprivate var _date: String!
    fileprivate var _weatherType: String!
    fileprivate var _highTemp: String!
    fileprivate var _lowTemp: String!
    
    var date: String
    {
        if _date == nil
        {
            _date = ""
        }
        
        return _date
    }
    
    var weatherType: String
    {
        if _weatherType == nil
        {
            _weatherType = ""
        }
        
        return _weatherType
    }

    var highTemp: String
    {
        if _highTemp == nil
        {
            _highTemp = ""
        }
        
        return _highTemp
    }
    
    var lowTemp: String
    {
        if _lowTemp == nil
        {
            _lowTemp = ""
        }
        
        return _lowTemp
    }

    init(weatherDict: Dictionary<String, Any>)
    {
        if let temp = weatherDict["temp"] as? Dictionary<String, Any>
        {
            if let min = temp["min"] as? Double
            {
                let kelvinToCelsius = Int(round(min - 273.15))
                self._lowTemp = "\(kelvinToCelsius)"
            }
            
            if let max = temp["max"] as? Double
            {
                let kelvinToCelsius = Int(round(max - 273.15))
                self._highTemp = "\(kelvinToCelsius)"
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, Any>]
        {
            if let main = weather[0]["main"] as? String
            {
                self._weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double
        {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeak()
        }
    }
}

extension Date
{
    func dayOfTheWeak() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
    }
}
