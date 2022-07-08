//
//  CompanyAnnotation.swift
//  CompanyScanner
//
//  Created by coolishbee on 2022/06/23.
//

import Foundation
import MapKit

class CompanyAnnotation: MKPointAnnotation {
    
    let company: CompanyInfo
    init(company: CompanyInfo) {
        self.company = company
        super.init()
    }
    
    static func make(from companies: [CompanyInfo]) -> [CompanyAnnotation] {
        let annotations = companies.map { (company) -> CompanyAnnotation in
            let annotation = CompanyAnnotation(company: company)
            annotation.title = company.name
            annotation.subtitle = company.addr
            annotation.coordinate = CLLocationCoordinate2DMake(company.latitude, company.longitude)
            return annotation
        }
        return annotations
    }
}
