//
//  Location.swift
//  Weather
//
//  Created by Mitrio on 05.05.2022.
//

import Foundation
import CoreLocation

struct LocationCoordinates: LocationCoordinatesProtocol {
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
}
