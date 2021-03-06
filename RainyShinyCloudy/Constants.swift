//
//  Constants.swift
//  RainyShinyCloudy
//
//  Created by Ken Krippeler on 07.07.17.
//  Copyright © 2017 Lichtverbunden. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "bd5fcbadd1515617e843a066121f8c54"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=bd5fcbadd1515617e843a066121f8c54"
let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=bd5fcbadd1515617e843a066121f8c54"
