//
//  ForecastCollectionViewCell.swift
//  WeatherView
//
//  Created by Raul Riera on 28/07/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell, ForecastViewDisplayable {
    
    var forecast: Forecast? {
        didSet {
            didUpdateForecast()
        }
    }
    private var dayLabel: UILabel?
    private var conditionsView: ConditionsView?
    
    static var identifier: String {
        return "ForecastCollectionViewCell"
    }
    
    internal func configureSubviews() {
        if let conditionsView = conditionsView {
            return
        }
        
        dayLabel = UILabel(frame: frame)
        
        dayLabel?.font = .systemFontOfSize(12)
        dayLabel?.textColor = .whiteColor()
        dayLabel?.textAlignment = .Center
        dayLabel?.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        contentView.addSubview(dayLabel!)
        
        conditionsView = ConditionsView(frame: frame, font: UIFont.systemFontOfSize(20, weight:UIFontWeightThin))
        conditionsView?.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        contentView.addSubview(conditionsView!)
        
        let views = ["dayLabel": dayLabel!, "conditionsView": conditionsView!]
        
        let horizontalConstraintsConditionsView = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[conditionsView]-0-|", options: .allZeros, metrics: nil, views: views)
        let horizontalConstraintsDayLabel = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[dayLabel]-0-|", options: .allZeros, metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[dayLabel]-0-[conditionsView]-0-|", options: .allZeros, metrics: nil, views: views)
        
        NSLayoutConstraint.activateConstraints(horizontalConstraintsConditionsView + horizontalConstraintsDayLabel + verticalConstraints)
    }
        
    internal func didUpdateForecast() {
        configureSubviews()
        
        if let forecast = forecast, let dayLabel = dayLabel, let conditionsView = conditionsView {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "EEE"
            dayLabel.text = dateFormatter.stringFromDate(forecast.date)
            
            conditionsView.forecast = forecast
        }
    }

}