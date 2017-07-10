//
//  WeatherCell.swift
//  RainyShinyCloudy
//
//  Created by Ken Krippeler on 10.07.17.
//  Copyright © 2017 Lichtverbunden. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell
{
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    func configureCell(forecast: Forecast)
    {
        lowTemp.text = forecast.lowTemp
        highTemp.text = forecast.highTemp
        weatherType.text = forecast.weatherType
        weatherIcon.image = UIImage(named: "\(forecast.weatherType) Mini")
        dayLabel.text = forecast.date
    }
    


}
