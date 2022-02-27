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

extension Notification.Name {
    static let networkStatusChanged = Notification.Name("networkStatusChanged")
}

enum NetworkChangeNotifier {
    case network, reachability
}

protocol NetworkConnectivityProtocol {
    var isConnected: Bool { get }
    var connectionType: ConnectionType { get }
}

protocol NetworkMonitoringProtocol {
    func startMonitoring()
    func stopMonitoring()
}
