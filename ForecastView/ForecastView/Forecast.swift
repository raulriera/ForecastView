//
//  Forecast.swift
//  WeatherView
//
//  Created by Raul Riera on 28/07/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import Foundation

public struct Forecast {
    public let high: Temperature
    public let low: Temperature
    public let conditions: Conditions
    public let date: NSDate
    
    init(high: Temperature, low: Temperature, conditions: Conditions, date: NSDate) {
        self.high = high
        self.low = low
        self.conditions = conditions
        self.date = date
    }
}