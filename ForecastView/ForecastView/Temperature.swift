//
//  Temperature.swift
//  WeatherView
//
//  Created by Raul Riera on 28/07/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import Foundation

/**
A temperature value type.
*/
public struct Temperature {
    let celsius: Int
    let fahrenheit: Int
    let format: TemperatureFormat
    
    /// Temperature reading in the format specified.
    public var value: Int {
        switch format {
        case .Celsius:
            return celsius
        case .Fahrenheit:
            return fahrenheit
        case .Automatic:
            let isMetricSystem = NSLocale.currentLocale().objectForKey(NSLocaleUsesMetricSystem) as! Bool
            
            if isMetricSystem {
                return celsius
            } else {
                return fahrenheit
            }
        }
    }
    
    /**
    Temperature format to display to the user.
    
    - Automatic:	Reads the current locale to determine the best format to display
    - Celsius:		Displays the temperature in celsius
    - Fahrenheit:	Displays the temperature in fahrenheit
    */
    public enum TemperatureFormat {
        case Automatic
        case Celsius
        case Fahrenheit
    }
    
    /**
    Creates an instance of the temperature value type.
    
    - parameter celsius:	temperature reading in celsius
    - parameter fahrenheit:	temperature reading in fahrenheit
    - parameter format:		temperature format to display
    */
    init(celsius: Int, fahrenheit: Int, format: TemperatureFormat = .Celsius) {
        self.celsius = celsius
        self.fahrenheit = fahrenheit
        self.format = format
    }
}