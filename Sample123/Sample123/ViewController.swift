//
//  ViewController.swift
//  Sample123
//
//  Created by navaneeth-pt4855 on 07/03/22.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        let camera = GMSCameraPosition.camera(withLatitude: -38.86, longitude: 151.20, zoom: 5.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.camera = camera
        self.view.addSubview(mapView)
        
        let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
                marker.title = "Sydney"
                marker.snippet = "Australia"
                marker.map = mapView
    }


}

