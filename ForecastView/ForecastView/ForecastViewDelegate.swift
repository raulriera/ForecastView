//
//  ForecastViewDelegate.swift
//  WeatherView
//
//  Created by Raul Riera on 29/07/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

/**
*  The ForecastViewDelegate protocol defines methods that allow you to manage the selection of items in a forecast view and to perform actions on those items.
*/
public protocol ForecastViewDelegate {
    /**
    Asks the delegate for the size of the specified item
    
    :param: forecastView the view displaying the weather information
    :param: index        the index of the conditions
    
    :returns: The width and height of the specified item.
    */
    func forecastView(forecastView: ForecastView, sizeForItemAtIndex index: Int) -> CGSize
}