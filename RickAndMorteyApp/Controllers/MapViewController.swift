//
//  MapViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 03.11.2021.
//
import GooglePlaces
import GoogleMaps
import UIKit

class MapViewController: UIViewController {

    @IBOutlet var mapView: GMSMapView!
    private let googleMapsApiKey = "AIzaSyBTJL9Ge4DxkwqEzkfOcqo10LZABDf1DWY"
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    var preciseLocationZoomLevel: Float = 15.0
    var approximateLocationZoomLevel: Float = 10.0






    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.view = GoogleMapManager.shared.setGoogleMap()
            
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
