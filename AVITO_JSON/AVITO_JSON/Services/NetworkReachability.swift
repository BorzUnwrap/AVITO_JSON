//
//  NetworkReachability.swift
//  AVITO_JSON
//
//  Created by admin on 09.09.2021.
//  Copyright © 2021 ZanLabEngine. All rights reserved.
//

import Network

class NetworkReachability {
    
    static let shared = NetworkReachability()
    private var monitor: NWPathMonitor?
    private var isMonitoring = false
    
    var netStatusChangeHandler: (() -> Void)?
    
    var isConnected: Bool {
        guard let monitor = monitor else { return false }
        print(monitor.currentPath.status)
        return monitor.currentPath.status == .satisfied
    }
    
    var interfaceType: NWInterface.InterfaceType? {
        guard let _ = monitor else { return nil }
        return self.availableInterfacesTypes?.first
    }
    
    private var availableInterfacesTypes: [NWInterface.InterfaceType]? {
        guard let monitor = monitor else { return nil }
        return monitor.currentPath.availableInterfaces.map { $0.type }
    }
    
    func startMonitoring() {
        
        if isMonitoring { return }
        
        monitor = NWPathMonitor()
        
        let queue = DispatchQueue(label: "Monitor")
        monitor?.start(queue: queue)
        monitor?.pathUpdateHandler = { _ in
            self.netStatusChangeHandler?()
        }
        isMonitoring = true
    }
}
