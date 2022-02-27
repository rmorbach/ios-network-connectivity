//
//  ViewController.swift
//  NetworkCheckerSample
//
//  Created by Rodrigo Morbach on 25/02/22.
//

import UIKit

final class ViewController: UIViewController {

    private let networkConnectivity: NetworkConnectivityProtocol
    
    init(with networkConnectivity: NetworkConnectivityProtocol) {
        self.networkConnectivity = networkConnectivity
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateConnectionUI()
    }
        
    override func loadView() {
        let contentView = ContentView()
        self.view = contentView
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(networkChanged(sender:)), name: .networkStatusChanged, object: nil)
    }
    
    @objc private func networkChanged(sender: Any?) {
        DispatchQueue.main.async {
            self.updateConnectionUI()
        }
    }
    
    private func updateConnectionUI() {
        (view as? ContentView)?.updateIsConnected(networkConnectivity.isConnected)
        (view as? ContentView)?.updateConnectionType(networkConnectivity.connectionType)
    }
}

