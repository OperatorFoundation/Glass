//
//  Server.swift
//  Glass
//
//  Created by Dr. Brandon Wiley on 8/22/21.
//

import Foundation
import Network

public class Server
{
    let queue: DispatchQueue = DispatchQueue(label: "Glass.Server")
    let listener: NWListener

    public init?()
    {
        let tcpOptions = NWProtocolTCP.Options()
        tcpOptions.enableKeepalive = true
        tcpOptions.keepaliveIdle = 2

        let parameters = NWParameters(tls: nil, tcp: tcpOptions)
        parameters.includePeerToPeer = true
        guard let listener = try? NWListener(using: parameters) else {return nil}
        self.listener = listener

        BonjourController.instance.register(listener: self.listener, name: "Glass", type: BonjourController.glassType)

        self.listener.newConnectionHandler = self.handle
        self.listener.start(queue: self.queue)
    }

    private func handle(_ conn: NWConnection)
    {
        RoutingController.addPeer(Peer(conn))
    }
}
