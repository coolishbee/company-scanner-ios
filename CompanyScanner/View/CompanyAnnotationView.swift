//
//  CompanyAnnotationView.swift
//  CompanyScanner
//
//  Created by coolishbee on 2022/06/23.
//

import Foundation
import MapKit

class CompanyAnnotationView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
//            guard let companyAnnotation = newValue as? CompanyAnnotation else {
//                return
//            }
            clusteringIdentifier = "companyClusterIdentifier"
            
            //canShowCallout = true
            
            //let disclosureButton = UIButton(type: .detailDisclosure)
            //disclosureButton.tintColor = UIColor(named: "buttonTextColor")
            //rightCalloutAccessoryView = disclosureButton
            
            glyphImage = UIImage(named: "building")
            //markerTintColor = UIColor.yellow
            //displayPriority = .defaultHigh
        }
    }
}
