//
//  ViewController.swift
//  NetworkCheckerSample
//
//  Created by Rodrigo Morbach on 25/02/22.
//

import UIKit
import Network

final class ViewController: UIViewController {
        
    init() {
        super.init(nibName: nil, bundle: nil)
        addObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
        
    override func loadView() {
        let contentView = ContentView()
        self.view = contentView
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(networkChanged(sender:)), name: .networkStatusChanged, object: nil)
    }
    
    @objc private func networkChanged(sender: Notification) {
        DispatchQueue.main.async {
            let notifier = sender.userInfo?["notifier"] as? NetworkChangeNotifier ?? .network
            
            let object = sender.object as? NetworkConnectivityProtocol
                        
            self.updateConnectionUI(notifier: notifier, networkConnectivity: object)
        }
    }
    
    private func updateConnectionUI(notifier: NetworkChangeNotifier,
                                    networkConnectivity: NetworkConnectivityProtocol?) {
        guard let ntc = networkConnectivity else { return }
        let info = NetworkInfoTO(isConnected: ntc.isConnected,
                                 connectionType: ntc.connectionType)
        switch notifier {
        case .network:
            (view as? ContentView)?.updateNetworkManagerInfo(info)
        case .reachability:
            (view as? ContentView)?.updateReachabilityNetworkInfo(info)
        }
    }
}

