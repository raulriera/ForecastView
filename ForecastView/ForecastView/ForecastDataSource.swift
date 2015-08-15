//
//  ForecastDataSource.swift
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
public protocol ForecastDataSource {
    /**
    Asks the data source for the items in the specified coordinates. (required)
    
    - parameter coordinates: location coordinates for the weather conditions
    - parameter completion:  handler contains either the array of Forecast elements or an error
    */
    func forecastForCoordinates(coordinates: CLLocationCoordinate2D, completion:(data: [Forecast]?, error: NSError?) -> Void)
}

extension ForecastDataSource {
    
    /**
    Helper method to fetch data asynchronously. Creates an HTTP GET request for the specified URL, then calls a handler upon completion.
    
    - parameter url: endpoint to fetch the data from
    - parameter completion:  handler contains either the data or an error
    */
    public func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        let loadDataTask = NSURLSession.sharedSession().dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            if let responseError = error {
                completion(data: nil, error: responseError)
            } else {
                completion(data: data, error: nil)
            }
        }
        
        loadDataTask.resume()
    }

}