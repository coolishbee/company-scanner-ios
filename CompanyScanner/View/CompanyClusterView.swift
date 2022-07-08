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
            if let cluster = newValue as? MKClusterAnnotation {
                let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
                let count = cluster.memberAnnotations.count
                
                let someCount = 10
                let someColor = UIColor.green
                
                image = renderer.image { _ in
                    //UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 40, height: 40)).fill()
                    
                    someColor.setFill()
                    let someEndAngle: CGFloat = (CGFloat.pi * 2.0 * CGFloat(someCount)) / CGFloat(count)
                    
                    let piePath = UIBezierPath()
                    piePath.addArc(withCenter: CGPoint(x: 20, y: 20), radius: 20,
                                   startAngle: 0, endAngle: someEndAngle,
                                   clockwise: true)
                    piePath.addLine(to: CGPoint(x: 20, y: 20))
                    piePath.close()
                    piePath.fill()
                    
                    // Fill inner circle with white color
                    UIColor.white.setFill()
                    UIBezierPath(ovalIn: CGRect(x: 8, y: 8, width: 24, height: 24)).fill()
                    
                    // Finally draw count text vertically and horizontally centered
                    let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.black,
                                       NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]
                    let text = "\(count)"
                    let size = text.size(withAttributes: attributes)
                    let rect = CGRect(x: 20 - size.width / 2, y: 20 - size.height / 2, width: size.width, height: size.height)
                    text.draw(in: rect, withAttributes: attributes)
                }
                
            }
        }
        didSet {
            let disclosureButton = UIButton(type: .detailDisclosure)
            disclosureButton.tintColor = UIColor.black
            rightCalloutAccessoryView = disclosureButton
        }
    }
}
