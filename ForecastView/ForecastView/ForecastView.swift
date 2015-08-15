//
//  ForecastView.swift
//  WeatherView
//
//  Created by Raul Riera on 29/07/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit
import CoreLocation

@IBDesignable public class ForecastView: UIView {
    
    private var collectionView: UICollectionView!
    private let layout = UICollectionViewFlowLayout()
    private var state: ForecastViewState = .Collapsed {
        didSet {
            guard expandable else { return }
            
            collectionView.reloadData()
            collectionView.layoutIfNeeded()
            
            UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.6, options: .BeginFromCurrentState, animations: { [weak self] in
                self?.invalidateIntrinsicContentSize()
                self?.superview?.layoutIfNeeded()
                }, completion: nil)
        }
    }
    private var items = [Forecast]() {
        didSet {
            NSOperationQueue.mainQueue().addOperationWithBlock {
                self.collectionView.reloadData()
            }
        }
    }
    
    /// Duration in seconds of the expanding and collapsing animation
    @IBInspectable public var duration: Double = 0.25
    /// Support to expand the Forecast View to display more than one weather conditions
    @IBInspectable public var expandable: Bool = true
    /// An object that adopts the ForecastDataSource protocol is responsible for providing the data required by a forecast view.
    public var dataSource: ForecastDataSource?
    /// The ForecastViewDelegate protocol defines methods that allow you to manage the selection of items in a forecast view and to perform actions on those items.
    public var delegate: ForecastViewDelegate?
    /// These coordinates with the datasource are used to gather the weather conditions information to display
    public var coordinates: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0) {
        didSet {
            dataSource?.forecastForCoordinates(coordinates) { [weak self] (data, error) in
                if let data = data {
                    self?.items = data
                }
            }
        }
    }
    
    private enum ForecastViewState {
        case Collapsed
        case Expanded
        
        mutating func toggle() {
            if self == .Collapsed {
                self = .Expanded
            } else {
                self = .Collapsed
            }
        }
    }
        
    private func numberOfDays() -> Int {
        if items.isEmpty {
            return 0
        }
        
        switch state {
        case .Collapsed:
            return 1
        default:
            return items.count
        }
    }
    
    // MARK: Initialisers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViews()
    }
    
    // MARK: Overrides
    
    override public func intrinsicContentSize() -> CGSize {
        if let collectionView = collectionView {
            return collectionView.contentSize
        } else {
            return super.intrinsicContentSize()
        }
    }
    
    // MARK: Private
    
    private func configureViews() {
        layout.scrollDirection = .Horizontal
        
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.registerClass(SimpleForecastCollectionViewCell.self, forCellWithReuseIdentifier: SimpleForecastCollectionViewCell.identifier)
        collectionView.registerClass(ForecastCollectionViewCell.self, forCellWithReuseIdentifier: ForecastCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clearColor()
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
        
        let views = ["collectionView": collectionView!]
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[collectionView]-0-|", options: .AlignAllBaseline, metrics: nil, views: views)
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[collectionView]-0-|", options: .AlignAllBaseline, metrics: nil, views: views)
        
        NSLayoutConstraint.activateConstraints(verticalConstraints + horizontalConstraints)
    }
    
    // MARK: Interface Builder
    
    override public func prepareForInterfaceBuilder() {
        backgroundColor = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1)
        
        let debugLabel = UILabel(frame: frame)
        debugLabel.font = UIFont.systemFontOfSize(20, weight: UIFontWeightBlack)
        debugLabel.textColor = UIColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 1)
        debugLabel.numberOfLines = 0
        debugLabel.lineBreakMode = .ByWordWrapping
        debugLabel.textAlignment = .Center
        debugLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(debugLabel)
        
        debugLabel.text = "Forecast View"
        
        let views = ["label": debugLabel]
        
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[label]-|", options: [], metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[label]-|", options: [], metrics: nil, views: views)
        
        NSLayoutConstraint.activateConstraints(horizontalConstraints + verticalConstraints)
    }
    
}

extension ForecastView: UICollectionViewDataSource {
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfDays()
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let forecast = items[indexPath.row]
        let cell: ForecastViewDisplayable
        
        if indexPath.row == 0 {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(SimpleForecastCollectionViewCell.identifier, forIndexPath: indexPath) as! SimpleForecastCollectionViewCell
        } else {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(ForecastCollectionViewCell.identifier, forIndexPath: indexPath) as! ForecastCollectionViewCell
        }
        
        cell.forecast = forecast
        
        return cell as! UICollectionViewCell
    }
    
}

extension ForecastView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        state.toggle()
    }
    
}

extension ForecastView: UICollectionViewDelegate {
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if let delegate = delegate {
            return delegate.forecastView(self, sizeForItemAtIndex: indexPath.row)
        } else {
            if indexPath.row == 0 {
                return CGSize(width: 100, height: 60)
            } else {
                return CGSize(width: 75, height: 45)
            }
        }
    }
    
}
