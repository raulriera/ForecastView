//
//  ForecastDatasource.swift
//  WeatherView
//
//  Created by Raul Riera on 29/07/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import Foundation
import CoreLocation

/**
*  An object that adopts the ForecastDatasource protocol is responsible for providing the data required by a forecast view.
*/
public protocol ForecastDatasource {
    /**
    Asks the data source for the items in the specified coordinates. (required)
    
    - parameter coordinates: location coordinates for the weather conditions
    - parameter completion:  handler after container either the array of Forecast elements or an error
    */
    func forecastForCoordinates(coordinates: CLLocationCoordinate2D, completion:(data: [Forecast]?, error: NSError?) -> Void)
}