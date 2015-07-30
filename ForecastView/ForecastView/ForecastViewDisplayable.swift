//
//  ForecastViewDisplayable.swift
//  WeatherView
//
//  Created by Raul Riera on 29/07/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import Foundation

protocol ForecastViewDisplayable {
    static var identifier: String { get }
    var forecast: Forecast? { get set }
    
    func configureSubviews()
    func didUpdateForecast()
}