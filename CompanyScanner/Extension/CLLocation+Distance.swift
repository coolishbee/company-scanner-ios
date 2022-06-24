//
//  CLLocation+Distance.swift
//  CompanyScanner
//
//  Created by coolishbee on 2022/06/21.
//

import MapKit

extension CLLocation {
    
    class func distance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return to.distance(from: from)
    }
}
