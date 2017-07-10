//
//  Location.swift
//  RainyShinyCloudy
//
//  Created by Ken Krippeler on 10.07.17.
//  Copyright © 2017 Lichtverbunden. All rights reserved.
//

import Foundation
import CoreLocation

class Location
{
    static var sharedInstance = Location()
    private init(){}
    
    var latitude: Double!
    var longitude: Double!
}
