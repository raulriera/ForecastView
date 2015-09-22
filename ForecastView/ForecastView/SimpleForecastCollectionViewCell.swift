//
//  SimpleForecastCollectionViewCell.swift
//  WeatherView
//
//  Created by Raul Riera on 29/07/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

class SimpleForecastCollectionViewCell: UICollectionViewCell, ForecastViewDisplayable {
    
    var forecast: Forecast? {
        didSet {
            didUpdateForecast()
        }
    }
    private var conditionsView: ConditionsView?
        
    static var identifier: String {
        return "SimpleForecastCollectionViewCell"
    }
    
    internal func configureSubviews() {
        if let _ = conditionsView {
            return
        }
        
        if #available(iOS 8.2, *) {
            conditionsView = ConditionsView(frame: frame, font: UIFont.systemFontOfSize(32, weight: UIFontWeightThin))
        } else {
            conditionsView = ConditionsView(frame: frame, font: UIFont.systemFontOfSize(32))
        }
        
        conditionsView?.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(conditionsView!)
        
        let views = ["conditionsView": conditionsView!]
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[conditionsView]-0-|", options: [], metrics: nil, views: views)
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[conditionsView]-0-|", options: [], metrics: nil, views: views)
        
        NSLayoutConstraint.activateConstraints(verticalConstraints + horizontalConstraints)
    }
    
    internal func didUpdateForecast() {
        configureSubviews()
        
        if let forecast = forecast, let conditionsView = conditionsView {
            conditionsView.forecast = forecast
        }
    }
}
