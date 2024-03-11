//
//  SocketHandler.swift
//  GameNodeJs
//
//  Created by Ehab on 09/03/2024.
//

import Foundation
import SocketIO

class SocketHandler: NSObject {
    static let sharedInstance = SocketHandler()
    let socket = SocketManager(socketURL: URL(string: "https://game-node-js-5412cbf208fc.herokuapp.com")!, config: [.log(true), .compress])
//    let socket = SocketManager(socketURL: URL(string: "http://192.168.1.7:3000")!, config: [.log(true), .compress])
//    let socket = SocketManager(socketURL: URL(string: "http://localhost:3000")!, config: [.log(true), .compress])
    var mSocket: SocketIOClient!
    
    override init() {
        super.init()
        mSocket = socket.defaultSocket
    }
    
    func getSocket() -> SocketIOClient {
        return mSocket
    }
    
    func establishConnection() {
        mSocket.connect()
    }
    
    func closeConnection() {
        mSocket.disconnect()
    }
}

