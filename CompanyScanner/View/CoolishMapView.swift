//
//  CoolishMapView.swift
//  CompanyScanner
//
//  Created by coolishbee on 2022/06/21.
//

import MapKit
import SwiftUI

struct CoolishMapView: UIViewRepresentable, CoolishMapViewProtocol {
    @Binding var annotations: [CompanyAnnotation]?
    
    var viewModel: CompaniesInfoViewModel?
    var mapView: UIView {
        return mkMapView
    }
    
    private let mkMapView: MKMapView = {
        let map = MKMapView(frame: .zero)
        map.showsUserLocation = true
        map.userTrackingMode = .follow
        return map
    }()
    
    // MARK: UIViewRepresentable protocol
    func makeUIView(context: Context) -> MKMapView {
        registerAnnotationViewClasses()
        mkMapView.delegate = context.coordinator
        
        let button = MKUserTrackingButton(mapView: mkMapView)
        button.layer.backgroundColor = UIColor(white: 1, alpha: 0.8).cgColor
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        mkMapView.addSubview(button)
        
        let scale = MKScaleView(mapView: mkMapView)
        scale.legendAlignment = .trailing
        scale.translatesAutoresizingMaskIntoConstraints = false
        mkMapView.addSubview(scale)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: mkMapView.bottomAnchor, constant: -65),
            button.trailingAnchor.constraint(equalTo: mkMapView.trailingAnchor, constant: -13),
            scale.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -10),
            scale.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        
        return mkMapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        print("updateUIView")
        guard let annotations = annotations, viewModel?.isRefreshed ?? false else {
            return
        }
        viewModel?.isRefreshed.toggle()
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(annotations)
    }
    
    func registerAnnotationViewClasses() {
        mkMapView.register(CompanyAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
    }
    
    func makeCoordinator() -> CoolishLocationCoordinator {
        print("makeCoordinator")
        return CoolishLocationCoordinator(mapView: self,
                                          locationManager: CLLocationManager())
    }
    
    func setRegion(_ region: MKCoordinateRegion, needUpdate: Bool, animated: Bool) {
        print("setRegion")
        viewModel?.regionTuple = (region.center.latitude, region.center.longitude)
        if needUpdate {
            mkMapView.setRegion(region, animated: animated)
            viewModel?.requestCompaniesAPI()
            viewModel?.canRefresh = false
        }
    }
}

extension MKPointAnnotation {
    //static var exampleRegionTuple = (37.559211, 126.835865)
    static var example: CompanyAnnotation {
        let testCompany = CompanyInfo(code: AnyIntValue.int(1), name: "게임펍", addr: "퀸즈파크나인", type: "게임회사", lat: nil, lng: nil)
        let annotation = CompanyAnnotation(company: testCompany)
        annotation.title = "게임펍"
        annotation.subtitle = "테스트"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.559211, longitude: 126.835865)
        return annotation
    }
}
