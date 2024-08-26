//
//  SocketManager.swift
//  socket-io-ios-app
//
//  Created by Kien on 19/8/24.
//

import Foundation
import SocketIO

class RTCManager {
    static let shared = RTCManager()
    
    private var manager: SocketManager
    var socket: SocketIOClient
    
    private init() {
        let socketURL = URL(string: "http://192.168.50.221:3000")!
        manager = SocketManager(socketURL: socketURL, config: [.log(true), .compress])
        socket = manager.defaultSocket
        
        // Handle connection
        socket.on(clientEvent: .connect) { data, ack in
            print("Socket connected")
        }

        // Handle disconnection
        socket.on(clientEvent: .disconnect) { data, ack in
            print("Socket disconnected")
        }
    }
    
    func connect() {
        socket.connect()
    }

    func sendMessage(_ message: String) {
        socket.emit("message", message)
    }

    func disconnect() {
        socket.disconnect()
    }
}
