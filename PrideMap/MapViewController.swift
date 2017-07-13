//
//  MapViewController.swift
//  PrideMap
//
//  Created by Felix Hedlund on 2017-07-13.
//  Copyright © 2017 Felix Hedlund. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var map: MKMapView!
    var routeLine: MKPolyline!
    override func viewDidLoad() {
        super.viewDidLoad()
        let sourceLocation = CLLocationCoordinate2D(latitude: 59.326798, longitude: 18.043357)
        let destinationLocation = CLLocationCoordinate2D(latitude: 59.345832, longitude: 18.082318)
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Start: Stockholm Pride Parade"
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "Finish: Pride park"
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        self.map.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        
        
        var lineArray = [CLLocationCoordinate2D]()
        lineArray.append(sourceLocation)
        lineArray.append(CLLocationCoordinate2D(latitude: 59.326776, longitude: 18.047588))
        lineArray.append(CLLocationCoordinate2D(latitude: 59.326883, longitude: 18.050311))
        lineArray.append(CLLocationCoordinate2D(latitude: 59.327167, longitude: 18.053069))
        lineArray.append(CLLocationCoordinate2D(latitude: 59.327907, longitude: 18.052950))
        lineArray.append(CLLocationCoordinate2D(latitude: 59.328268, longitude: 18.057377))
        lineArray.append(CLLocationCoordinate2D(latitude: 59.328136, longitude: 18.059173))
        lineArray.append(CLLocationCoordinate2D(latitude: 59.328530, longitude: 18.061221))
        lineArray.append(CLLocationCoordinate2D(latitude: 59.333749, longitude: 18.056481))
        lineArray.append(CLLocationCoordinate2D(latitude: 59.335524, longitude: 18.063456))
        lineArray.append(CLLocationCoordinate2D(latitude: 59.335825, longitude: 18.065059))
        lineArray.append(CLLocationCoordinate2D(latitude: 59.336225, longitude: 18.072467))
        lineArray.append(CLLocationCoordinate2D(latitude: 59.336383, longitude: 18.072966))
        lineArray.append(CLLocationCoordinate2D(latitude: 59.343421, longitude: 18.078798))
        lineArray.append(CLLocationCoordinate2D(latitude: 59.345276, longitude: 18.080949))
        lineArray.append(destinationLocation)
        
        
        routeLine = MKPolyline(coordinates: lineArray, count: lineArray.count)
        let originRect = routeLine.boundingMapRect
        let originPoint = MKMapPoint(x: originRect.origin.x - 2500, y: originRect.origin.y)
        let mapRect = MKMapRect(origin: originPoint, size: MKMapSize(width: originRect.size.width + 5000, height: originRect.size.height))
        map.setVisibleMapRect(mapRect, animated: true)
        map.add(routeLine)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            /* define a list of colors you want in your gradient */
            let gradientColors = [#colorLiteral(red: 0.8941176471, green: 0.01176470588, blue: 0.01176470588, alpha: 1),#colorLiteral(red: 1, green: 0.5490196078, blue: 0, alpha: 1),#colorLiteral(red: 1, green: 0.9294117647, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0.5019607843, blue: 0.1490196078, alpha: 1),#colorLiteral(red: 0, green: 0.3019607843, blue: 1, alpha: 1),#colorLiteral(red: 0.4588235294, green: 0.02745098039, blue: 0.5294117647, alpha: 1)]
            /* Initialise a JLTGradientPathRenderer with the colors */
            let polylineRenderer = JLTGradientPathRenderer(polyline: overlay as! MKPolyline, colors: gradientColors)
            /* set a linewidth */
            polylineRenderer.lineWidth = 10
            
            return polylineRenderer
        }else{
            return MKOverlayRenderer()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
