//
//  LocationManager.swift
//  Weather
//
//  Created by Tony Hillerson on 1/31/16.
//  Copyright © 2016 Seven Apps. All rights reserved.
//

import Foundation

import CoreLocation

protocol LocationManagerDelegate {
  func currentLocationDetermined(placename:String)
  func unableToDetermineLocation()
}

class LocationManager : NSObject, CLLocationManagerDelegate {
  
  let locationManager = CLLocationManager()
  var delegate:LocationManagerDelegate!
  
  required init(delegate:LocationManagerDelegate) {
    super.init()
    self.delegate = delegate
    locationManager.delegate = self
  }
  
  func determineCurrentLocation() {
    let status = CLLocationManager.authorizationStatus()
    if status == .NotDetermined {
      locationManager.requestWhenInUseAuthorization()
    } else if status == .AuthorizedAlways ||
              status == .AuthorizedWhenInUse {
      locationManager.startUpdatingLocation()
    } else {
      delegate.unableToDetermineLocation()
    }
  }
  
  // Core Location Delegate Methods
  
  func locationManager(manager: CLLocationManager,
    didChangeAuthorizationStatus status: CLAuthorizationStatus) {
      determineCurrentLocation()
  }
  
  func locationManager(manager: CLLocationManager,
    didFailWithError error: NSError) {
      delegate.unableToDetermineLocation()
  }
  
  func locationManager(manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]) {
      if let latestLocation:CLLocation = locations.first as CLLocation? {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(latestLocation,
          completionHandler: {
            [weak self] (results, error) -> Void in
            if let firstResult:CLPlacemark = results!.first as CLPlacemark? {
              var placeDescription = ""
              if let name = firstResult.name {
                placeDescription += name
              }
              if let thoroughfare = firstResult.thoroughfare {
                placeDescription += " \(thoroughfare)"
              }
              if let locality = firstResult.locality {
                placeDescription += " \(locality),"
              }
              if let administrativeArea = firstResult.administrativeArea {
                placeDescription += " \(administrativeArea)"
              }
              if let postalCode = firstResult.postalCode {
                placeDescription += " \(postalCode)"
              }
              if let code = firstResult.ISOcountryCode {
                placeDescription += " \(code)"
              }
              self?.locationManager.stopUpdatingLocation()
              self?.delegate.currentLocationDetermined(placeDescription)
            } else {
              self?.delegate.unableToDetermineLocation()
            }
          }
        )
      } else {
        delegate.unableToDetermineLocation()
      }
  }
  
}