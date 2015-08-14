# ForecastView

<img src="/Screenshots/Demo.gif" />

## Usage

Using the custom view is straightforward, the following code gets the instance of the library from a Storyboard and proceeds to use the [Wunderground.com](http://www.wunderground.com) datasource to fetch the weather forecast for the city `Valencia, Venezuela` (10.162 latitude and -68.0077 longitude)

``` swift
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

}
```

A beautiful icon set created by [Carlos Yllobre](http://twitter.com/charlieyllobre) is bundled with the `Example` project.

## Extending

If you wish to use other datasources, just create a class that implements the [ForecastDatasource](ForecastView/ForecastView/ForecastDatasource.swift) protocol. It's that easy.

Want to use your own icons? Supply the icon filename in the [Conditions](ForecastView/ForecastView/Conditions.swift) model. Checkout the [ConditionsView](ForecastView/ForecastView/ConditionsView.swift) for more information about this.

## Installation

### Manual

The easiest way to install this framework is to drag and drop the `ForecastView/ForecastView` folder into your project. This also prevents the `frameworks` problem in iOS where the IBInspectable and IBDesignable are stripped out.

### Cocoapods

Add the following to your Podfile:

``` ruby
use_frameworks!
pod "ForecastView"
```

### Carthage

Add the following to your Cartfile:

``` ruby
github "raulriera/ForecastView"
```
### Swift 1.2

Looking for a Swift 1.2 version? Try the `swift-1.2` [branch](https://github.com/raulriera/ForecastView/tree/swift-2.0).

## Created by
Raul Riera, [@raulriera](http://twitter.com/raulriera)  
Carlos Yllobre [@charlieyllobre](http://twitter.com/charlieyllobre)
