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

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)49.768056\(LONGITUDE)6.116667\(APP_ID)\(API_KEY)"
