//
//  RoutingController.swift
//  Glass
//
//  Created by Dr. Brandon Wiley on 8/22/21.
//

import Foundation

public class RoutingController
{
    public static let instance = RoutingController()

    var peers: Set<Peer> = Set<Peer>()

    public init()
    {
    }

    static public func addPeer(_ peer: Peer)
    {
        let firstPeer = instance.peers.count == 0

        instance.peers.insert(peer)

        if firstPeer && instance.peers.count == 1
        {
            // FIXME - handle failure here
            let _ = startRouting()
        }
    }

    static public func startRouting() -> Bool
    {
        return AudioController.instance.startRouting()
    }
}
