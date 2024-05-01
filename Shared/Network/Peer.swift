//
//  Peer.swift
//  Glass
//
//  Created by Dr. Brandon Wiley on 8/22/21.
//

import Foundation
import Network

public class Peer
{
    public let id: Int

    let conn: NWConnection

    public init(_ conn: NWConnection)
    {
        self.conn = conn

        self.id = self.conn.endpoint.hashValue
    }
}

extension Peer: Equatable
{
    public static func == (lhs: Peer, rhs: Peer) -> Bool
    {
        lhs.id == rhs.id
    }
}

extension Peer: Hashable
{
    public func hash(into hasher: inout Hasher)
    {
        hasher.combine(self.id)
    }
}
