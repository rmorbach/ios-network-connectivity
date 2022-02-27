//
//  ContentView.swift
//  NetworkMonitorSample
//
//  Created by Rodrigo Morbach on 27/02/22.
//

import UIKit

final class ContentView: UIView {
    
    private lazy var uiNetworkManagerView: NetworkInfoView = {
        makeView(type: NetworkInfoView.self)
    }()
    
    private lazy var uiReachabilityNetworkView: NetworkInfoView = {
        makeView(type: NetworkInfoView.self)
    }()
    
    private lazy var uiStackView: UIStackView = {
        let view = makeView(type: UIStackView.self)
        view.axis = .vertical
        view.spacing = 40
        return view
    }()
    
    private lazy var uiScrollView: UIScrollView = {
        let scroll = makeView(type: UIScrollView.self)
        return scroll
    }()
    
    private lazy var uiContainerView: UIView = {
        makeView(type: UIView.self)
    }()
    
    private lazy var uiNetworkLabel: UILabel = {
        let label = makeView(type: UILabel.self)
        label.textColor = .blue
        label.text = "Network Framework"
        return label
    }()
    
    private lazy var uiReachabilityLabel: UILabel = {
        let label = makeView(type: UILabel.self)
        label.textColor = .blue
        label.text = "Reachability Framework"
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func updateNetworkManagerInfo(_ info: NetworkInfoTO) {
        uiNetworkManagerView.updateIsConnected(info.isConnected)
        uiNetworkManagerView.updateConnectionType(info.connectionType)
    }
    
    func updateReachabilityNetworkInfo(_ info: NetworkInfoTO) {
        uiReachabilityNetworkView.updateIsConnected(info.isConnected)
        uiReachabilityNetworkView.updateConnectionType(info.connectionType)
    }
    
    private func makeView<T: UIView>(type: T.Type) -> T {
        let view = type.init()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
}

extension ContentView: CodeView {
    func setupViews() {
        uiStackView.addArrangedSubview(uiNetworkLabel)
        uiStackView.addArrangedSubview(uiNetworkManagerView)
        uiStackView.addArrangedSubview(uiReachabilityLabel)
        uiStackView.addArrangedSubview(uiReachabilityNetworkView)
        uiContainerView.addSubview(uiStackView)
        uiScrollView.addSubview(uiContainerView)
        addSubview(uiScrollView)
    }
    func setupConstraints() {
        uiStackView.topAnchor.constraint(equalTo: uiContainerView.topAnchor).isActive = true
        uiStackView.trailingAnchor.constraint(equalTo: uiContainerView.trailingAnchor, constant: -16).isActive = true
        uiStackView.bottomAnchor.constraint(equalTo: uiContainerView.bottomAnchor).isActive = true
        uiStackView.leadingAnchor.constraint(equalTo: uiContainerView.leadingAnchor, constant: 16).isActive = true
        
        uiContainerView.topAnchor.constraint(equalTo: uiScrollView.topAnchor, constant: 60.0).isActive = true
        uiContainerView.trailingAnchor.constraint(equalTo: uiScrollView.trailingAnchor).isActive = true
        uiContainerView.bottomAnchor.constraint(equalTo: uiScrollView.bottomAnchor).isActive = true
        uiContainerView.leadingAnchor.constraint(equalTo: uiScrollView.leadingAnchor).isActive = true
        uiContainerView.widthAnchor.constraint(equalTo: uiScrollView.widthAnchor).isActive = true
                
        uiScrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        uiScrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        uiScrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        uiScrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
        let heightConstraint = uiContainerView.heightAnchor.constraint(equalTo: uiScrollView.heightAnchor, multiplier: 1.0)
        heightConstraint.priority = .defaultLow
        heightConstraint.isActive = true

    }
    func setupExtra() {
        
    }
}
