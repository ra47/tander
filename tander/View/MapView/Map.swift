//
//  mapView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 18/1/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI
import MapKit

struct Map: UIViewRepresentable {
    
    var locationManager = CLLocationManager()
    var mapVM : MapViewModel
    
     func setupManager() {
       locationManager.desiredAccuracy = kCLLocationAccuracyBest
       locationManager.requestWhenInUseAuthorization()
       locationManager.requestAlwaysAuthorization()
     }
    
    func makeUIView(context: Context) -> MKMapView {
        setupManager()
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        updateAnnotations(from: view)
    }
    
    private func updateAnnotations(from mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        let newAnnotations = mapVM.restaurants.map { RestaurantAnnotation(restaurant: $0) }
      mapView.addAnnotations(newAnnotations)
    }
}

