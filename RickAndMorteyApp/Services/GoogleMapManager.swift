//
//  GoogleMapManager.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 03.11.2021.
//

import Foundation
import GoogleMaps

class GoogleMapManager {

    static let shared = GoogleMapManager()

    private let googleMapsApiKey = "AIzaSyBTJL9Ge4DxkwqEzkfOcqo10LZABDf1DWY"
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var preciseLocationZoomLevel: Float = 15.0
    var approximateLocationZoomLevel: Float = 10.0

    private init() {}


    func setGoogleMap(){
        func setGoogleMap(){
            GMSServices.provideAPIKey(googleMapsApiKey)
        }
    }
}
