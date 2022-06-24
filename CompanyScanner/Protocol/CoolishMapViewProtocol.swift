//
//  CoolishMapViewProtocol.swift
//  CompanyScanner
//
//  Created by coolishbee on 2022/06/21.
//

import Foundation
import MapKit

protocol CoolishMapViewProtocol {
    var mapView: UIView { get }
    
    func setRegion(_ region: MKCoordinateRegion, needUpdate: Bool, animated: Bool)
}

extension CoolishMapViewProtocol {
    func setRegion(_ region: MKCoordinateRegion, needUpdate: Bool, animated: Bool) {}
    
    var mkMapView: MKMapView? {
        return mapView as? MKMapView
    }
}
