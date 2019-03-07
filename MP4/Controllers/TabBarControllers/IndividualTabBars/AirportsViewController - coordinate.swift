//
//  AirportsViewController - coordinate.swift
//  LufthansaMP4Skeleton
//
//  Created by Ethan Wong on 3/5/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import CoreLocation

extension AirportsViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last?.coordinate
        centerMap()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
