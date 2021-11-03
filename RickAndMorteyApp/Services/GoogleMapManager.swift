//
//  GoogleMapManager.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 03.11.2021.
//

import Foundation
import GooglePlaces
import GoogleMaps

class GoogleMapManager {

    static let shared = GoogleMapManager()

    private let googleMapsApiKey = "AIzaSyBTJL9Ge4DxkwqEzkfOcqo10LZABDf1DWY"
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var preciseLocationZoomLevel: Float = 15.0
    var approximateLocationZoomLevel: Float = 10.0

    private init() {}


    func setGoogleMap() -> UIView {

        GMSServices.provideAPIKey(googleMapsApiKey)

        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)


        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView

        return mapView
    }
}

