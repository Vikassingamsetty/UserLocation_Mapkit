//
//  ViewController.swift
//  DispplayUserLocation
//
//  Created by Srans022019 on 22/04/20.
//  Copyright © 2020 vikas. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    var mapView:MKMapView!
    var locationManager:CLLocationManager!
    
    
    
    let centerMapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "arrow")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCentreOnUserLocation), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurMapView()
        configureLocationManager()
        enableLocationService()
        centerMapOnUseLocation()
        
        //Constrains
        view.addSubview(centerMapButton)
        centerMapButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44).isActive = true
        centerMapButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        centerMapButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        centerMapButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        centerMapButton.layer.cornerRadius = 40 / 2
        centerMapButton.alpha = 1
        
        // Do any additional setup after loading the view.
    }
    
    //Mark: Seletor
    @objc func handleCentreOnUserLocation() {
        centerMapOnUseLocation()
    }
    
    
    
    //MARK:- Helper functions
    
    func centerMapOnUseLocation() {
        
        guard let coordinate = locationManager.location?.coordinate else {return}
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(region, animated: true)
        
    }
    
    
    func configureLocationManager() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
    }
    
    func configurMapView() {
        
        mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        view.addSubview(mapView)
        mapView.frame = view.frame
    }

}

extension ViewController : CLLocationManagerDelegate {
    
    func enableLocationService() {
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            print("notDetermined")
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
        default:
            print("Error in authorization")
        }
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnUseLocation()
    }
    
}

