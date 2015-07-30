//
//  Temperature.swift
//  WeatherView
//
//  Created by Raul Riera on 28/07/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import Foundation

public struct Temperature {
    public let celsius: Int
    public let fahrenheit: Int
    
    init(celsius: Int, fahrenheit: Int) {
        self.celsius = celsius
        self.fahrenheit = fahrenheit
    }
}