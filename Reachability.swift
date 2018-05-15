//
//  Reachability.swift
//  Plowz&Mowz
//
//  Created by Navjot_sharma on 5/8/17.
//  Copyright © 2017 Navjot_Sharma. All rights reserved.
//


import Foundation
import SystemConfiguration

class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags : SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        //        let isReachable = flags.contains(.Reachable)
        //        let needsConnection = flags.contains(.ConnectionRequired)
        
        // For Swift 3, replace the last two lines by
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        
        return (isReachable && !needsConnection)
    }
}
