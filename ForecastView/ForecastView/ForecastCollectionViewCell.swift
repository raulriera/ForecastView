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
    
    lazy private var dayLabel: UILabel = {
        let label = UILabel(frame: CGRectZero)
        
        label.font = .systemFontOfSize(12)
        label.textColor = .whiteColor()
        label.textAlignment = .Center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy private var conditionsView: ConditionsView = {
        let font: UIFont
        
        if #available(iOS 8.2, *) {
            font = UIFont.systemFontOfSize(20, weight: UIFontWeightThin)
        } else {
            font = UIFont.systemFontOfSize(20)
        }
        let view = ConditionsView(frame: CGRectZero, font: font)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    static var identifier: String {
        return "ForecastCollectionViewCell"
    }
    
    internal func configureSubviews() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(conditionsView)
        
        let views = ["dayLabel": dayLabel, "conditionsView": conditionsView]
        
        let horizontalConstraintsConditionsView = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[conditionsView]-0-|", options: [], metrics: nil, views: views)
        let horizontalConstraintsDayLabel = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[dayLabel]-0-|", options: [], metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[dayLabel]-0-[conditionsView]-0-|", options: [], metrics: nil, views: views)
        
        NSLayoutConstraint.activateConstraints(horizontalConstraintsConditionsView + horizontalConstraintsDayLabel + verticalConstraints)
    }
        
    internal func didUpdateForecast() {
        configureSubviews()
        
        if let forecast = forecast {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "EEE"
            dayLabel.text = dateFormatter.stringFromDate(forecast.date)
            
            conditionsView.forecast = forecast
        }
    }

}