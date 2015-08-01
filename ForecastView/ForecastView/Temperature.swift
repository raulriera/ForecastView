//
//  Temperature.swift
//  WeatherView
//
//  Created by Raul Riera on 28/07/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import Foundation

public struct Temperature {
    let celsius: Int
    let fahrenheit: Int
    let format: TemperatureFormat
    
    public var value: Int {
        switch format {
        case .Celsius:
            return celsius
        case .Fahrenheit:
            return fahrenheit
        }
    }
    
    public enum TemperatureFormat {
        case Celsius
        case Fahrenheit
    }
    
    init(celsius: Int, fahrenheit: Int, format: TemperatureFormat = .Celsius) {
        self.celsius = celsius
        self.fahrenheit = fahrenheit
        self.format = format
    }
}