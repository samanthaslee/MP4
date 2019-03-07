//
//  LufthansaAPIClient.swift
//  MP4
//
//  Created by Elizabeth Lee on 3/5/19.
//  Copyright © 2019 Sam Lee. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON // FIXME

class LufthansaAPIClient {
    //These are where we will store all of the authentication information. Get these from your account at developer.lufthansa.com.
    static let clientSecret = "VNn6FbjJyX" //FIXME
    static let clientID = "fwskdyqp6p665wjhjxs62fh4" //FIXME
    
    //This variable will store the session's auth token that we will get from getAuthToken()
    static var authToken: String?
    
    //This function will request an auth token from the lufthansa servers
    static func getAuthToken(completion: @escaping () -> ()){
        
        //This is the information that will be sent to the server to authenticate our device
        let requestURL = "https://api.lufthansa.com/v1/oauth/token" //FIXME
        let parameters = ["client_id": "\(clientID)", "client_secret": "\(clientSecret)", "grant_type": "client_credentials"] //FIXME
        
        //GET RID OF THIS
        //completion()
        
        //This is the POST request made to the lufthansa servers to get the authToken for this session.
        Alamofire.request(requestURL, method: .post, parameters: parameters, encoding: URLEncoding()).responseJSON { response in
            
            //Converts response to JSON object and sets authToken variable to appropriate value
            let json = JSON(response.result.value) //FIXME
            self.authToken = json["access_token"].stringValue//FIXME
            
            print("Auth token: " + self.authToken!)
            print("This key expires in " + json["expires_in"].stringValue + " seconds\n")
            
            //Runs completion closure
            completion()
        }
    }
    
    //This function will get the status for a flight. FlightNum format "LHXXX" Date format "YYYY-MM-DD"
    static func getFlightStatus(flightNum: String, date: String, completion: @escaping (Flight) -> ()){
        
        //Request URL and authentication parameters
        let requestURL = "https://api.lufthansa.com/v1/operations/flightstatus/\(flightNum)/\(date)" //FIXME
        let parameters: HTTPHeaders = ["Accept":"application/json", "Authorization":"Bearer \(self.authToken!)"] //FIXME
        
        //print("PARAMETERS FOR REQUEST:")
        //print(parameters)
        //print("\n")
        
        //GET RID OF THIS
        //completion(Flight())
        
        Alamofire.request(requestURL, headers: parameters).responseJSON { response in
            //Makes sure that response is valid
            guard response.result.isSuccess else {
                print(response.result.error.debugDescription)
                return
            }
            //Creates JSON object
            let json = JSON(response.result.value) //FIXME
            print(json)
            //Create new flight model and populate data
            let flight = Flight(data: json) //FIXME
            completion(flight)
        }
    }
    
    static func getCustomerInfo(flightNum: String, date: String, completion: @escaping (Flight) -> ()){
        
        //Request URL and authentication parameters
        let requestURL = "https://api.lufthansa.com/v1/operations/customerflightinformation/\(flightNum)/\(date)" //FIXME
        let parameters: HTTPHeaders = ["Accept":"application/json", "Authorization":"Bearer \(self.authToken!)"] //FIXME
        
        //print("PARAMETERS FOR REQUEST:")
        //print(parameters)
        //print("\n")
        
        //GET RID OF THIS
        //completion(Flight())
        
        Alamofire.request(requestURL, headers: parameters).responseJSON { response in
            //Makes sure that response is valid
            guard response.result.isSuccess else {
                print(response.result.error.debugDescription)
                return
            }
            //Creates JSON object
            let json = JSON(response.result.value) //FIXME
            print(json)
            //Create new flight model and populate data
            let flight = Flight(data: json) //FIXME
            completion(flight)
        }
    }
    
    static func allAirports(UIView: UIViewController, completion: @escaping ([Airport]) -> ()){
        
        //Request URL and authentication parameters
        
        let requestURL = "https://api.lufthansa.com/v1/references/airports/?limit=100&offset=0&LHoperated=0"
        let parameters: HTTPHeaders = ["Accept":"application/json", "Authorization":"Bearer \(self.authToken!)"] //FIXME
        
        //print("PARAMETERS FOR REQUEST:")
        //print(parameters)
        //print("\n")
        
        //GET RID OF THIS
        //completion(Flight())
        
        Alamofire.request(requestURL, headers: parameters).responseJSON { response in
            //Makes sure that response is valid
            guard response.result.isSuccess else {
                print(response.result.error.debugDescription)
                return
            }
            //Creates JSON object
            let json = JSON(response.result.value) //FIXME
            print(json)
            //Create new flight model and populate data
            //let flight = Airport(data: json) //FIXME
            
            var flightList : [Airport] = []
            for i in 0...99{
                let airportCode = json["AirportResource"]["Airports"]["Airport"][i]["AirportCode"].stringValue
                let singleAirport = Airport()
                singleAirport.airportCode = json["AirportResource"]["Airports"]["Airport"]["AirportCode"].stringValue
                singleAirport.airportName = json["AirportResource"]["Airports"]["Airport"][i]["AirportCode"].stringValue
                singleAirport.airportLat = json["AirportResource"]["Airports"]["Airport"][i]["Position"]["Coordinate"]["Latitude"].stringValue
                singleAirport.airportLong = json["AirportResource"]["Airports"]["Airport"][i]["Position"]["Coordinate"]["Longitude"].stringValue
                flightList.append(singleAirport)
                //["Airport"]["Position"]["Coordinate"]["Latitude"]
            }
            completion(flightList)
        }
    }
}

