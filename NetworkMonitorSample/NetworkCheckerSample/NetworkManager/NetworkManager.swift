//
//  NetworkManager.swift
//  NetworkCheckerSample
//
//  Created by Rodrigo Morbach on 25/02/22.
//

import Network
import Foundation


final class NetworkManager: NetworkConnectivityProtocol, NetworkMonitoringProtocol {
    
    static let shared: NetworkManager = .init()
    
    private let monitor: NWPathMonitor
            
    private let monitorQueue = DispatchQueue(label: "networkmanager.monitor-queue")
    
    private let isConnectedAccessQueue = DispatchQueue(label: "networkmanager.connected-queue")
    
    private let connectionTypeQueue = DispatchQueue(label: "networkmanager.connectiontype-queue")
    
    private var _isConnected: Bool = false
    
    private var _connectionType: ConnectionType = .none
    
    private(set) var connectionType: ConnectionType {
        get {
            var value: ConnectionType = .none
            connectionTypeQueue.sync {
                value = _connectionType
            }
            return value
        } set {
            connectionTypeQueue.sync {
                _connectionType = newValue
            }
        }
    }
    
    var isConnected: Bool {
        get {
            var value: Bool = false
            isConnectedAccessQueue.sync {
                value = _isConnected
            }
            return value
        } set {
            isConnectedAccessQueue.sync {
                _isConnected = newValue
            }
        }
    }
    
    private var hasStartedMonitoring = false
    
    private init() {
        monitor = .init()
    }
    
    func startMonitoring() {
        guard hasStartedMonitoring == false else { return }
        self._startMonitoring()
    }
    
    private func _startMonitoring() {
        hasStartedMonitoring = true
        monitor.pathUpdateHandler = { [weak self] path in
            print(path.status)
            self?._isConnected = path.status != .unsatisfied
            print("connected: \(self!.isConnected)")
            let currentConnection = path.availableInterfaces.first { interface -> Bool in
                return path.usesInterfaceType(interface.type)
            }
            
            guard let type = currentConnection?.type else {
                self?.connectionType = .none
                self?.notifyChanges()
                return
            }
                        
            switch type {
            case .cellular:
                self?.connectionType = .cellular
            case .wifi:
                self?.connectionType = .wifi
            case .loopback, .other, .wiredEthernet:
                self?.connectionType = .other
            @unknown default:
                self?.connectionType = .none
            }
            self?.notifyChanges()
        }
        monitor.start(queue: monitorQueue)
    }
    
    private func notifyChanges() {
        let notification = Notification(name: .networkStatusChanged,
                                        object: self,
                                        userInfo: ["notifier": NetworkChangeNotifier.network])
        NotificationCenter.default.post(notification)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
}

