//
//  BonjourController.swift
//  Glass
//
//  Created by Dr. Brandon Wiley on 8/22/21.
//

import Foundation
import Network

public class BonjourController: NSObject
{
    public static let instance: BonjourController = BonjourController()
    public static let glassType = "_glass._tcp"

    let browser: NetServiceBrowser = NetServiceBrowser()
    var foundServices: [NetService] = []

    override public convenience init()
    {
        self.init()

        self.browser.delegate = self
    }

    public func find(type: String, domain: String = "")
    {
        self.browser.searchForServices(ofType: type, inDomain: domain)
    }

    public func register(listener: NWListener, name: String, type: String)
    {
        listener.service = NWListener.Service(name: name, type: type)
    }
}

extension BonjourController: NetServiceBrowserDelegate
{
    public func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool)
    {
        foundServices.append(service)
    }
}

//extension BonjourController: NetServiceDelegate
//{
//}
