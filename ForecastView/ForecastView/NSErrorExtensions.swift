//
//  NSErrorExtensions.swift
//  ForecastView
//
//  Created by Raúl Riera on 02/08/2015.
//  Copyright © 2015 Raul Riera. All rights reserved.
//

import Foundation

extension NSError {
    
    /**
    Type of errors that can occur when creating a Forecast Datasource
    
    - InvalidJSON:	the JSON data is invalid
    - InvalidURL:	the URL is malformed or invalid
    - Unknown:		something bad happened
    */
    public enum ForecastDatasourceErrorType: Int {
        case InvalidJSON = 5001
        case InvalidURL = 5002
        case Unknown = 5000
    }
    
    /**
    Returns an NSError object initialized for this domain and code with a given userInfo dictionary.
    
    - parameter type:		the type of error that ocurred
    - parameter extraInfo:	The userInfo dictionary for the error. userInfo may be nil.
    
    - returns: An NSError object initialized with the specified error type and the dictionary of arbitrary data userInfo.
    */
    convenience init(_ type: ForecastDatasourceErrorType, extraInfo: [NSObject : AnyObject]? = nil) {
        self.init(domain: "com.raulriera.forecastView", code: type.rawValue, userInfo: extraInfo)
    }
}