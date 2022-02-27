//
//  NetworkConnectivityProtocol.swift
//  NetworkMonitorSample
//
//  Created by Rodrigo Morbach on 27/02/22.
//

import Foundation

enum ConnectionType: String {
    case cellular, wifi, none, other
}

protocol NetworkConnectivityProtocol {
    var isConnected: Bool { get }
    var connectionType: ConnectionType { get }
}
