//
//  CoolishLocationCoordinator.swift
//  CompanyScanner
//
//  Created by coolishbee on 2022/06/21.
//

import Foundation
import MapKit

class CoolishLocationCoordinator: NSObject {
    var mainMapView: CoolishMapViewProtocol
    var locationManager: CLLocationManager?
    
    fileprivate var beforeRegion: MKCoordinateRegion?
    
    init(mapView: CoolishMapViewProtocol, locationManager: CLLocationManager? = nil) {
        self.mainMapView = mapView
        self.locationManager = locationManager
        super.init()
        initLocationManager()
    }
    
    private func initLocationManager() {
        self.locationManager?.delegate = self
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
}

extension CoolishLocationCoordinator: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            break
        case .denied:
            print("denied")
            return
        case .notDetermined:
            self.locationManager?.requestWhenInUseAuthorization()
            return
        case .authorizedAlways:
            self.locationManager?.allowsBackgroundLocationUpdates = true
            self.locationManager?.pausesLocationUpdatesAutomatically = false
            break
        case .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
        self.locationManager?.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation])
    {
        guard let location = locations.last, let locationManager = self.locationManager else {
            return
        }
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                            longitude: location.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center,
                                        span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                               longitudeDelta: 0.01))
        self.mainMapView.setRegion(region, needUpdate: true, animated: false)
        self.mainMapView.viewModel?.canRefresh = false
        locationManager.stopUpdatingLocation()
    }
}

//MARK: - MKMapViewDelegate Delegate
extension CoolishLocationCoordinator: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("didSelect")        
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("didDeselect")
    }
    
    func mapView(_ mapView: MKMapView,
                 regionDidChangeAnimated animated: Bool)
    {
        print("regionDidChangeAnimated")
        if let center = beforeRegion?.center {
            let distance = CLLocation.distance(from: center, to: mapView.region.center)
            if distance > 1000 {
                self.mainMapView.viewModel?.canRefresh = true
                self.mainMapView.setRegion(mapView.region, needUpdate: false, animated: false)
            }
        }
        beforeRegion = mapView.region
    }
//MARK: - Obsolete
    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl)
    {
        if let annotation = view.annotation as? CompanyAnnotation {
            
            print("Annotation: \(annotation.title ?? "") : \(annotation.subtitle ?? "")")
            self.mainMapView.viewModel?.selectedAnnotation = annotation
            
        } else if let cluster = view.annotation as? MKClusterAnnotation {
            
            print("Annotations count: \(cluster.memberAnnotations.count)")
            self.mainMapView.viewModel?.selectedAnnotations = cluster.memberAnnotations as? [CompanyAnnotation]
        }
    }
}
