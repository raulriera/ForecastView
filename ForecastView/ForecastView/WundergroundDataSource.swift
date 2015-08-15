//
//  WundergroundDataSource.swift
//  WeatherView
//
//  Created by Raul Riera on 29/07/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import Foundation
import CoreLocation

public class WundergroundDataSource: ForecastDataSource {
    
    var apiKey: String
    
    var baseURL: String {
        return "http://api.wunderground.com/api/\(apiKey)/forecast/q/"
    }
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    public func forecastForCoordinates(coordinates: CLLocationCoordinate2D, completion:(data: [Forecast]?, error: NSError?) -> Void) {
        let resourceURL = NSURL(string: "\(baseURL)\(coordinates.latitude),\(coordinates.longitude).json")
        
        if let resourceURL = resourceURL {
            loadDataFromURL(resourceURL) { (data, error) in
                
                do {
                    let parsedObject = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    
                    var json: AnyObject? = parsedObject.objectForKey("forecast")
                    
                    if json == nil {
                        completion(data: .None, error: NSError(.InvalidJSON))
                        return
                    }
                    
                    json = json!["simpleforecast"]
                    json = json!["forecastday"]
                    
                    var items = [Forecast]()
                    
                    for node in json as! [NSDictionary] {
                        if  let celsiusHigh = node["high"]!["celsius"] as? NSString,
                            let fahrenheitHigh = node["high"]!["fahrenheit"] as? NSString,
                            let celsiusLow = node["low"]!["celsius"] as? NSString,
                            let fahrenheitLow = node["low"]!["fahrenheit"] as? NSString,
                            let epoch = node["date"]!["epoch"] as? NSString,
                            let conditionsTitle = node["conditions"] as? String,
                            let conditionsIcon = node["icon"] as? String {
                                
                                let high = Temperature(celsius: celsiusHigh.integerValue, fahrenheit: fahrenheitHigh.integerValue)
                                let low = Temperature(celsius: celsiusLow.integerValue, fahrenheit: fahrenheitLow.integerValue)
                                let conditions = Conditions(title: conditionsTitle, icon: conditionsIcon)
                                
                                let forecast = Forecast(high: high, low: low, conditions: conditions, date: NSDate(timeIntervalSince1970: epoch.doubleValue))
                                
                                items.append(forecast)
                        }
                        
                    }
                    
                    completion(data: items, error: error)
                    
                    
                } catch let error as NSError {
                    completion(data: .None, error: error)
                    return
                } catch {
                    fatalError()
                }
                
            }
        } else {
            completion(data: .None, error: NSError(.InvalidURL))
        }
        
    }
}