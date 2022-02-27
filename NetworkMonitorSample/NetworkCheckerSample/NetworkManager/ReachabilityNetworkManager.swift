//
//  ReachabilityNetworkManager.swift
//  NetworkMonitorSample
//
//  Created by Rodrigo Morbach on 27/02/22.
//

import Foundation
import Reachability

final class ReachabilityNetworkManager: NetworkConnectivityProtocol, NetworkMonitoringProtocol {
    
    private(set) var isConnected: Bool {
        get {
            return _isConnected
        } set {
            _isConnected = newValue
        }
    }
    
    private var _isConnected: Bool = false
    
    private var _connectionType: ConnectionType = .none
    
    private(set) var connectionType: ConnectionType {
        get {
            return _connectionType
        } set {
            _connectionType = newValue
        }
    }
    
    static let shared = ReachabilityNetworkManager()
    
    private let reachability: Reachability?
    
    private init() {
        reachability = try? Reachability()
    }
    
    private func listenToChanges() {
        reachability?.whenReachable = { [weak self] reach in
            self?.isConnected = true
            switch reach.connection {
            case .cellular:
                self?.connectionType = .cellular
            case .unavailable:
                self?.connectionType = .none
            case .wifi:
                self?.connectionType = .wifi
            case .none:
                self?.connectionType = .none
            }
            self?.notifyChanges()
        }
        
        reachability?.whenUnreachable = {[weak self] _ in
            self?.isConnected = false
            self?.connectionType = .none
            self?.notifyChanges()
        }
    }
    
    private var monitoringStarted = false
    
    private func notifyChanges() {
        let notification = Notification(name: .networkStatusChanged,
                                        object: self,
                                        userInfo: ["notifier": NetworkChangeNotifier.reachability])
        NotificationCenter.default.post(notification)
    }
    
    func startMonitoring() {
        
        guard monitoringStarted == false else { return }
        
        let result = Result {
            try reachability?.startNotifier()
        }
        switch result {
        case .success(_):
            monitoringStarted = true
            listenToChanges()
            print("Started monitoring")
        default:
            print("Unable to start monitoring")
        }
    }
    
    func stopMonitoring() {
        reachability?.stopNotifier()
    }
    
    
    
}
