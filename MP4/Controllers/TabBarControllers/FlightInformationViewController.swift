//
//  FlightInformationViewController.swift
//  LufthansaMP4Skeleton
//
//  Created by Ethan Wong on 3/5/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit
import MapKit

class FlightInformationViewController: UIViewController, MKMapViewDelegate {
    
    var flight: Flight!
    
    var flightNumber: String!
    var flightDate: String!
    
    var infoLabel : UILabel!
    
    var deparatureLabel: UILabel!
    var deparatureAirportLabel: UILabel!
    var deparatureScheduledDateLabel: UILabel!
    var departureScheduledDateSmallLabel: UILabel!
    var deparatureTimeLabel: UILabel!
    var deparatureTimeSmallLabel: UILabel!
    var deparatureStatusLabel: UILabel!
    var deparatureStatusSmallLabel: UILabel!
    
    var arrivalLabel: UILabel!
    var arrivalAirportLabel: UILabel!
    var arrivalScheduledDateLabel: UILabel!
    var arrivalTimeLabel: UILabel!
    var arrivalStatusLabel: UILabel!
    
    var aircraftLabel: UILabel!
    var aircraftNameLabel: UILabel!
    
    var arrivalImageView: UIImageView!
    var deparatureImageView: UIImageView!
    
    var favoritesButton: UIButton!
    
    var fullFlightID: String!
    
    @objc var favoriteButtonClicked = false
    
    var favoritedList = [String:String]()
    
    var departureLatitude: Double = 0.0
    var departureLongitude: Double = 0.0
//
    var arrivalLatitude: Double = 0.0
    var arrivalLongitude: Double = 0.0
    
    var airportMapView: MKMapView!
    
    

    
    override func viewDidLoad() {
        self.tabBarController?.tabBar.isHidden = false
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpFlightInfo()
        getFlightInfo()
        //getDepartureAirportCoord()
        //getArrivalAirportCoord()
        self.tabBarController?.tabBar.isHidden = false
        
        //createAnnotations(locations: annotationLocations)
        let annotationLocations = [
            ["title": self.deparatureAirportLabel.text, "latitude" : departureLatitude, "longitude" : departureLongitude],
            ["title": self.arrivalAirportLabel.text, "latitude" : arrivalLatitude, "longitude" : arrivalLongitude]
        ]
        
        self.title = flightNumber
        
        //map shit
        airportMapView = MKMapView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 350))
        airportMapView.delegate = self
        view.addSubview(airportMapView)
        
        let centerLocation = CLLocationCoordinate2DMake(40.00023, -86.3345)
//        let location = CLLocationCoordinate2DMake(28.6139, 77.2090)
////        //let centerLocation = CLLocationCoordinate2DMake(37.60, 63.674)
//        let span = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
//        let region = MKCoordinateRegion(center: location, span: span)
//        //let region = MKCoordinateRegion(location, span)
        let region = MKCoordinateRegion(center: centerLocation, latitudinalMeters: 200000, longitudinalMeters: 200000)
        airportMapView.setRegion(region, animated: true)
////
        for location in annotationLocations {
            let annotations = MKPointAnnotation()
            annotations.title = location["title"] as? String
            annotations.coordinate = CLLocationCoordinate2DMake(location["latitude"] as! CLLocationDegrees, location["longitude"] as! CLLocationDegrees)
            airportMapView?.addAnnotation(annotations)
        }
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = location
//        annotation.title = "Airport"
//        airportMapView.addAnnotation(annotation)
//
        
        let favoritesButton = UIButton(type: .custom)
        favoritesButton.setImage(UIImage(named: "favorites"), for: .normal)
        favoritesButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        favoritesButton.addTarget(self, action: #selector(favoriteClicked), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: favoritesButton)
        
//        let favoritesButton = UIBarButtonItem(title: "Favorite", style: .done, target: self, action: #selector(getter: favoriteButtonClicked))
//        favoritesButton.addtar
        self.navigationItem.rightBarButtonItem  = item1

        // Do any additional setup after loading the view.
        
        //post request = getting auth token
        //get request = getting flight information
    }
    
//    @objc func createAnnotations(locations: [[String : Any]]) {
//        for location in locations {
//            let annotations = MKPointAnnotation()
//            annotations.title = location["title"] as? String
//            annotations.coordinate = CLLocationCoordinate2DMake(location["latitude"] as! CLLocationDegrees, location["longitude"] as! CLLocationDegrees)
//
//            airportMapView?.addAnnotation(annotations)
//        }
//    }
    
    @objc func getFlightInfo() {
    
        LufthansaAPIClient.getAuthToken() {
            LufthansaAPIClient.getCustomerInfo(flightNum: self.flightNumber, date: self.flightDate) { flt in
        
        self.deparatureAirportLabel.text = flt.departureAirport
        self.arrivalAirportLabel.text = flt.arrivalAirport
                
        self.deparatureScheduledDateLabel.text = flt.departureDate
        self.deparatureTimeLabel.text = flt.departureTime
        self.deparatureStatusLabel.text = flt.departureStatus
        
        self.arrivalScheduledDateLabel.text = flt.arrivalDate
        self.arrivalTimeLabel.text = flt.arrivalTime
        self.arrivalStatusLabel.text = flt.arrivalStatus
                
        self.fullFlightID = flt.fullID
            
        self.flight = flt
                
        self.aircraftNameLabel.text = flt.aircraft
            }
            
        }
    }
    
//    @objc func getDepartureAirportCoord() {
//        LufthansaAPIClient.getAuthToken() {
//            LufthansaAPIClient.getAirportCoord(airportCode: self.deparatureAirportLabel.text as! String) { flt in
//                
//                self.departureLatitude = flt.latitude
//                self.departureLongitude = flt.longitude
//                
//            }
//        }
//        
//    }
//    
//    @objc func getArrivalAirportCoord() {
//        LufthansaAPIClient.getAuthToken() {
//            LufthansaAPIClient.getAirportCoord(airportCode: self.arrivalAirportLabel.text as! String) { flt in
//                
//                self.arrivalLatitude = flt.latitude
//                self.arrivalLongitude = flt.longitude
//                
//            }
//        }
//        
//    }
    
    @objc func getAirportInfo() {
        LufthansaAPIClient.getAuthToken() {
            LufthansaAPIClient.getCustomerInfo(flightNum: self.flightNumber, date: self.flightDate) { flt in
                
                self.deparatureAirportLabel.text = flt.departureAirport
                self.arrivalAirportLabel.text = flt.arrivalAirport
                
                self.deparatureScheduledDateLabel.text = flt.departureDate
                self.deparatureTimeLabel.text = flt.departureTime
                self.deparatureStatusLabel.text = flt.departureStatus
                
                self.arrivalScheduledDateLabel.text = flt.arrivalDate
                self.arrivalTimeLabel.text = flt.arrivalTime
                self.arrivalStatusLabel.text = flt.arrivalStatus
                
                
            }
        }
        
    }
    
    @objc func setUpFlightInfo() {
        infoLabel = UILabel(frame: CGRect(x: 80, y: 360, width: 260, height: 30 ))
        infoLabel.text = "Here is your flight information!"
        infoLabel.textColor = .black
        infoLabel.textAlignment = .center
        view.addSubview(infoLabel)
        
        deparatureImageView = UIImageView(frame: CGRect (x: 60, y: 415, width: 75, height: 75))
        deparatureImageView.image = UIImage(named: "departure")
        view.addSubview(deparatureImageView)
        
        arrivalImageView = UIImageView(frame: CGRect (x: 280, y: 415, width: 75, height: 75))
        arrivalImageView.image = UIImage(named: "arrival")
        view.addSubview(arrivalImageView)
        
        deparatureAirportLabel = UILabel(frame: CGRect(x: 60, y: 490, width: 260, height: 30 ))
        //deparatureAirportLabel.text = "D.AIRPORT"
        deparatureAirportLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        view.addSubview(deparatureAirportLabel)
        
        arrivalAirportLabel  = UILabel(frame: CGRect(x: 280, y: 490, width: 260, height: 30 ))
        arrivalAirportLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        view.addSubview(arrivalAirportLabel)
        
        deparatureLabel = UILabel(frame: CGRect(x: 50, y: 565, width: 270, height: 30 ))
        deparatureLabel.text = "Departure"
        deparatureLabel.textColor = UIColor(red:0.24, green:0.28, blue:0.45, alpha:1.0)
        view.addSubview(deparatureLabel)
        
        deparatureScheduledDateLabel = UILabel(frame: CGRect(x: 50, y: 600, width: 260, height: 30 ))
        deparatureScheduledDateLabel.text = "N/A"
        deparatureScheduledDateLabel.textColor = .black
        view.addSubview(deparatureScheduledDateLabel)
        
        deparatureTimeLabel = UILabel(frame: CGRect(x: 160, y: 600, width: 100, height: 30 ))
        deparatureTimeLabel.text = "N/A"
        deparatureTimeLabel.textAlignment = .center
        deparatureTimeLabel.textColor = .black
        view.addSubview(deparatureTimeLabel)
        
        deparatureStatusLabel = UILabel(frame: CGRect(x: 270, y: 600, width: 260, height: 30 ))
        deparatureStatusLabel.text = "N/A"
        deparatureStatusLabel.textColor = .black
        view.addSubview(deparatureStatusLabel)
        
        arrivalLabel = UILabel(frame: CGRect(x: 50, y: 645, width: 260, height: 30 ))
        arrivalLabel.text = "Arrival"
        arrivalLabel.textColor = UIColor(red:0.24, green:0.28, blue:0.45, alpha:1.0)
        view.addSubview(arrivalLabel)
        
        arrivalScheduledDateLabel = UILabel(frame: CGRect(x: 50, y: 680, width: 260, height: 30 ))
        arrivalScheduledDateLabel.text = "N/A"
        arrivalScheduledDateLabel.textColor = .black
        view.addSubview(arrivalScheduledDateLabel)
        
        arrivalTimeLabel = UILabel(frame: CGRect(x: 160, y: 680, width: 100, height: 30 ))
        arrivalTimeLabel.text = "N/A"
        arrivalTimeLabel.textColor = .black
        arrivalTimeLabel.textAlignment = .center
        view.addSubview(arrivalTimeLabel)
        
        arrivalStatusLabel = UILabel(frame: CGRect(x: 270, y: 680, width: 260, height: 30 ))
        arrivalStatusLabel.text = "N/A"
        arrivalStatusLabel.textColor = .black
        view.addSubview(arrivalStatusLabel)
        
        aircraftLabel = UILabel(frame: CGRect(x: 50, y: 720, width: 270, height: 30 ))
        aircraftLabel.text = "Aircraft"
        aircraftLabel.textColor = UIColor(red:0.24, green:0.28, blue:0.45, alpha:1.0)
        view.addSubview(aircraftLabel)
        
        aircraftNameLabel = UILabel(frame: CGRect(x: 50, y: 755, width: 260, height: 30 ))
        aircraftNameLabel.text = "N/A"
        aircraftNameLabel.textColor = .black
        view.addSubview(aircraftNameLabel)
        
        
//        favoritesButton = UIButton(frame: CGRect(x: 80, y: 560, width: 260, height: 30 ))
//        favoritesButton.backgroundColor =  .blue
//        favoritesButton.setTitleColor(.white, for: .normal)
//        favoritesButton.setTitle("Favorite", for: .normal)
//        favoritesButton.addTarget(self, action: #selector(favoriteClicked), for: .touchUpInside)
//        favoritesButton.layer.cornerRadius = 5
//        view.addSubview(favoritesButton)
        
//        let favoritesButton = UIButton(type: .custom)
//        favoritesButton.setImage(UIImage(named: "favorites"), for: .normal)
//        favoritesButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        favoritesButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
//        let item1 = UIBarButtonItem(customView: favoritesButton)
//
//
//        self.navigationItem.setRightBarButtonItems([item1], animated: true)
        
    }
    
    @objc func favoriteClicked() {
        //favoriteButtonClicked = true
    
        
        if favoriteButtonClicked == false {
            favoriteButtonClicked = true
            print("favclicked")
            createFavAlert(title: "Flight is favorited.", message: "Find it in your favorites!")
            //favoritesButton.setImage(UIImage(named: "favoritesfilled"), for: .normal)
            print(fullFlightID)
            //Constants.favorites.append("hello")
            
            Constants.favorites.append(flight)
            print(String(fullFlightID))
            
            //Constants.favorites.append(["flightID": flightNumber, "flightD": flightDate])
            print(Constants.favorites)
            //FavoritesViewController.favoritedFlights.append[fullFlightID]
            
        } else {
            print("faveunclicked")
            createFavAlert(title: "Flight has already been favorited.", message: "")
            //favoritesButton.setImage(UIImage(named: "favoritesfilled"), for: .normal)
        }
    }
    
    func createFavAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
