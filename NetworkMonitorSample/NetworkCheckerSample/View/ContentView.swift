//
//  ContentView.swift
//  NetworkCheckerSample
//
//  Created by Rodrigo Morbach on 25/02/22.
//

import UIKit

protocol CodeView {
    func setup()
    func setupViews()
    func setupConstraints()
    func setupExtra()
}

extension CodeView {
    func setup() {
        setupViews()
        setupConstraints()
        setupExtra()
    }
}


final class ContentView: UIView {
    
    private lazy var uiConnectedSwitch: UISwitch = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isOn = false
        view.isEnabled = false
        return view
    }()
    
    private lazy var uiConnectedLabel: UILabel = {
        let view = UILabel()
        view.text = "Is Connected?"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var uiConnectionTypeLabel: UILabel = {
        let view = UILabel()
        view.text = "Connection Type"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var uiConnectionTypeValueLabel: UILabel = {
        let view = UILabel()
        view.text = "Undefined"
        view.textAlignment = .right
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var uiConnectionStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        return view
    }()
    
    private lazy var uiConnectionTypeStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        return view
    }()
    
    private lazy var uiContainerStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 10
        view.axis = .vertical
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func updateIsConnected(_ connected: Bool) {
        uiConnectedSwitch.isOn = connected
    }
    
    func updateConnectionType(_ connectionType: ConnectionType) {
        self.uiConnectionTypeValueLabel.text = connectionType.rawValue.uppercased()
    }
}

extension ContentView: CodeView {
    func setupViews() {
        uiConnectionStack.addArrangedSubview(uiConnectedLabel)
        uiConnectionStack.addArrangedSubview(uiConnectedSwitch)
        
        uiConnectionTypeStack.addArrangedSubview(uiConnectionTypeLabel)
        uiConnectionTypeStack.addArrangedSubview(uiConnectionTypeValueLabel)
        
        uiContainerStack.addArrangedSubview(uiConnectionStack)
        uiContainerStack.addArrangedSubview(uiConnectionTypeStack)
        
        addSubview(uiContainerStack)
    }
    
    func setupConstraints() {
        uiContainerStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        uiContainerStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        uiContainerStack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setupExtra() {
        
    }
}
