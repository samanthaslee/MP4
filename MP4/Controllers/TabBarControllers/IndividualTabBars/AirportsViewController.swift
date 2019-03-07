////
////  AirportsViewController.swift
////  LufthansaMP4Skeleton
////
////  Created by Sam Lee on 3/4/19.
////  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
////
//
import UIKit
import MapKit

class AirportsViewController: UIViewController {

    
    var mapView: MKMapView!
    
    var location: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.

        self.title = "Airports"
        
        mapView = MKMapView()
        mapView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.delegate = self
        
        var mapRegion : MKCoordinateRegion  = MKCoordinateRegion()
        var coordinate :  CLLocationCoordinate2D = CLLocationCoordinate2D()
        coordinate.latitude = 48.499998
        coordinate.longitude = 23.3833318
        mapRegion.center = coordinate
        mapRegion.span.latitudeDelta = 40
        mapRegion.span.longitudeDelta = 50
        
        mapView.setRegion(mapRegion, animated: true)
        

        LufthansaAPIClient.allAirports(UIView: self, completion: ({airports in
            
            for airport in airports {
                let place = MKPointAnnotation()
                place.title = "\(airport.airportName), \(airport.airportCode!)"
                place.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees((airport.airportLat! as NSString).integerValue), longitude: CLLocationDegrees((airport.airportLong! as NSString).integerValue))
                self.mapView.addAnnotation(place)
            }
            self.view.addSubview(self.mapView)
        }))
        
        
        
    }

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
//        mapView.delegate = self as! MKMapViewDelegate
//        view.addSubview(mapView)
//
//        createAirports()
//
//        view.backgroundColor = .green
//
//        // Do any additional setup after loading the view.
//    }
    
    func centerMap() {
        //var location = CLLocationCoordinate2D(latitude: 37.87, longitude: -122.27)
        var region = MKCoordinateRegion(center: self.location, latitudinalMeters: 1000, longitudinalMeters: 1000)
        self.mapView.setRegion(region, animated : true)
    }
    
    // creating annotations, one for each student
//    func createAirports() {
//        LufthansaAPIClient.getAirportCoord(airportCode: "", completion: <#T##(Airport) -> ()#>)() {
//            LufthansaAPIClient.getCustomerInfo(flightNum: self.flightNumber, date: self.flightDate) { flt in
//                
//                self.deparatureAirportLabel.text = flt.departureAirport
//                self.arrivalAirportLabel.text = flt.arrivalAirport
//                
//                self.deparatureScheduledDateLabel.text = flt.departureDate
//                self.deparatureTimeLabel.text = flt.departureTime
//                self.deparatureStatusLabel.text = flt.departureStatus
//                
//                self.arrivalScheduledDateLabel.text = flt.arrivalDate
//                self.arrivalTimeLabel.text = flt.arrivalTime
//                self.arrivalStatusLabel.text = flt.arrivalStatus
//                
//                self.fullFlightID = flt.fullID
//                
//                self.flight = flt
//                
//                self.aircraftNameLabel.text = flt.aircraft
//            }
//        let airportAnnotation = Airport(location: CLLocationCoordinate2D(latitude: 37.866632800000005, longitude: -122.25206805335353), name: "AirportName", code: "ABC")
//        mapView.addAnnotation(airportAnnotation)
//    }
    

    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destination.
         Pass the selected object to the new view controller.
    }
    */

}
