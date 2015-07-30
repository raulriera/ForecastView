//
//  ViewController.swift
//  ForecastViewExample
//
//  Created by Raúl Riera on 30/07/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit
import CoreLocation
import ForecastView

class ViewController: UIViewController {

    @IBOutlet weak var forecastView: ForecastView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init the Forecast View
        forecastView.datasource = WundergroundDatasource(apiKey: "YOUR-API-KEY-FROM-WUNDERGROUND.COM")
        forecastView.coordinates = CLLocationCoordinate2DMake(10.162, -68.0077)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}

