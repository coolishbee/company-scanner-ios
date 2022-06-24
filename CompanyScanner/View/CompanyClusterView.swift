//
//  CompanyClusterView.swift
//  CompanyScanner
//
//  Created by coolishbee on 2022/06/23.
//

import MapKit

class CompanyClusterView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        displayPriority = .defaultHigh
        collisionMode = .circle
        centerOffset = CGPoint(x: 0, y: -10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var annotation: MKAnnotation? {
        willSet {
//            if let cluster = newValue as? MKClusterAnnotation {
//                let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
//                let count = cluster.memberAnnotations.count
//            }
        }
    }
}
