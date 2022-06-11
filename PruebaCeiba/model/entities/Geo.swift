//
//  Geo.swift
//  PruebaCeiba
//
//  Created by Santiago Rodriguez on 10/06/22.
//

import Foundation

// MARK: - Geo
class Geo: Codable {
    let lat, lng: String

    init(lat: String, lng: String) {
        self.lat = lat
        self.lng = lng
    }
}
