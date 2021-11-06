//
//  GoogleMapManager.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 03.11.2021.
//
import CoreLocation
import Foundation
import GooglePlaces
import GoogleMaps

class GoogleMapManager {

    static let shared = GoogleMapManager()

    private let googleMapsApiKey = "AIzaSyBTJL9Ge4DxkwqEzkfOcqo10LZABDf1DWY"
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var preciseLocationZoomLevel: Float = 15.0
    var approximateLocationZoomLevel: Float = 10.0
    var markers: [Marker] = []

    var latitude = 56.85
    var longtitude = 53.2

    private init() {}


    func setGoogleMap() -> UIView {

        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longtitude, zoom: 17)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.camera = camera

        for i in markers {
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longtitude))
            marker.map = mapView
            
        }

        

        return mapView
    }

    func addMarkerToMap(latitude: Double, longtitude: Double){
        CoreDataManager.shared.addMarker(latitude: latitude, lontitude: longtitude)
        self.markers = CoreDataManager.shared.fetchMarkers()

    }
}

