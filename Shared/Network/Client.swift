//
//  Client.swift
//  Glass
//
//  Created by Dr. Brandon Wiley on 8/22/21.
//

import Foundation
import Network

public class Client
{
    let queue: DispatchQueue = DispatchQueue(label: "Glass.Client")

    public init(endpoint: NWEndpoint)
    {
        let tcpOptions = NWProtocolTCP.Options()
        tcpOptions.enableKeepalive = true
        tcpOptions.keepaliveIdle = 2

        let parameters = NWParameters(tls: nil, tcp: tcpOptions)
        parameters.includePeerToPeer = true

        let conn = NWConnection(to: endpoint, using: parameters)
        conn.start(queue: self.queue)

        RoutingController.addPeer(Peer(conn))
    }
}
