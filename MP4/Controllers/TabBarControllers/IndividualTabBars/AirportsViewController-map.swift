//
//  AirportsViewController-map.swift
//  LufthansaMP4Skeleton
//
//  Created by Ethan Wong on 3/5/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import MapKit

extension AirportsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("In MKMapViewDelegate")
        guard let annotation = annotation as? Airport else {
            return nil
        }
        let identifier = "marker"
        let view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation as! MKAnnotation
            view = dequeuedView
            
        } else {
            print("Created a new view")
            //print(annotation.title)
            view = MKMarkerAnnotationView(annotation: annotation as! MKAnnotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        if control == view.rightCalloutAccessoryView{
            performSegue(withIdentifier: "toAirportInfo", sender: self)
            
            //Perform a segue here to navigate to another viewcontroller
            // On tapping the disclosure button you will get here
        }
    }
}
