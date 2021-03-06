//
//  LocationManager.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 04.11.2021.
//

import Foundation
import CoreLocation
import UIKit

public protocol LocalizationHelperDelegate: AnyObject {
    func didUpdateLocation(_ sender: CLLocation)
}

public class LocationManager: NSObject {

    public weak var delegate: LocalizationHelperDelegate?
    public static var shared = LocationManager()

    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        return locationManager
    }()

    private var currentLocation: CLLocationCoordinate2D?

    public func startUpdatingLocation() {
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }

    public func stopUpdatingLocation() {
        self.locationManager.stopUpdatingLocation()
    }

    public func getCurrentLocation() -> CLLocationCoordinate2D? {
        return self.currentLocation
    }

    public func getLat() -> Double{
        return self.currentLocation?.latitude ?? 0.0
    }

    public func getLon() -> Double{
        return self.currentLocation?.longitude ?? 0.0
    }
}

extension LocationManager: CLLocationManagerDelegate {

    public func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.first else { return }
        self.currentLocation = location.coordinate
        self.delegate?.didUpdateLocation(location)
    }
}
