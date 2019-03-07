//
//  Flight.swift
//  MP4
//
//  Created by Elizabeth Lee on 3/5/19.
//  Copyright © 2019 Sam Lee. All rights reserved.
//

import Foundation
import SwiftyJSON

class Flight {
    //FIXME
    
    
    var timeStatus: String
    
    var departureAirport: String
    var arrivalAirport: String
    
    var departureDate: String
    var departureTime: String
    var departureStatus: String
    
    var arrivalDate: String
    var arrivalTime: String
    var arrivalStatus: String
    
    var flightNumber: String
    var flightAirlineID: String
    
    var fullID: String
    
    var aircraft: String
    
    init(data: JSON) {
        timeStatus = data["FlightStatusResource"]["Flights"]["Flight"]["Departure"]["TimeStatus"]["Definition"].stringValue
        departureAirport = data["FlightInformation"]["Flights"]["Flight"]["Departure"]["AirportCode"].stringValue
        arrivalAirport = data["FlightInformation"]["Flights"]["Flight"]["Arrival"]["AirportCode"].stringValue
        
        departureDate = data["FlightInformation"]["Flights"]["Flight"]["Departure"]["Scheduled"]["Date"].stringValue
        departureTime = data["FlightInformation"]["Flights"]["Flight"]["Departure"]["Actual"]["Time"].stringValue
        departureStatus = data["FlightInformation"]["Flights"]["Flight"]["Departure"]["Status"]["Description"].stringValue
        
        arrivalDate = data["FlightInformation"]["Flights"]["Flight"]["Arrival"]["Scheduled"]["Date"].stringValue
        arrivalTime = data["FlightInformation"]["Flights"]["Flight"]["Arrival"]["Actual"]["Time"].stringValue
        arrivalStatus = data["FlightInformation"]["Flights"]["Flight"]["Arrival"]["Status"]["Description"].stringValue
        
        flightNumber = data["FlightInformation"]["Flights"]["Flight"]["MarketingCarrierList"]["MarketingCarrier"]["FlightNumber"].stringValue
        flightAirlineID = data["FlightInformation"]["Flights"]["Flight"]["MarketingCarrierLis"]["MarketingCarrier"]["AirlineID"].stringValue
        
        fullID = data["FlightInformation"]["Flights"]["Flight"]["MarketingCarrierList"]["MarketingCarrier"]["AirlineID"].stringValue + data["FlightInformation"]["Flights"]["Flight"]["MarketingCarrierList"]["MarketingCarrier"]["FlightNumber"].stringValue
        
        aircraft = data["FlightInformation"]["Flights"]["Flight"]["Equipment"]["AircraftCode"].stringValue
        
    }
}
