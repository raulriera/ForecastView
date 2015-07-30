//
//  Conditions.swift
//  WeatherView
//
//  Created by Raul Riera on 28/07/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import Foundation

public struct Conditions {
    public let title: String
    public let icon: String
    
    init(title: String, icon: String) {
        self.title = title
        self.icon = icon
    }
}