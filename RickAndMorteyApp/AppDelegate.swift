//
//  AppDelegate.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 03.09.2021.
//

import CoreData
import GoogleMaps
import GooglePlaces
import CoreLocation
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        TimerManager.shared.startStopTimer()
        CoreDataManager.shared.setTimerCount(count: CoreDataManager.shared.fetchTimerCount())
        GMSServices.provideAPIKey("AIzaSyBTJL9Ge4DxkwqEzkfOcqo10LZABDf1DWY")
        GMSPlacesClient.provideAPIKey("AIzaSyBTJL9Ge4DxkwqEzkfOcqo10LZABDf1DWY")
        GoogleMapManager.shared.latitude = LocationManager.shared.getLat()
        GoogleMapManager.shared.longtitude = LocationManager.shared.getLon()
        GoogleMapManager.shared.addMarkerToMap(latitude: LocationManager.shared.getLat(), longtitude: LocationManager.shared.getLon())
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }



}

