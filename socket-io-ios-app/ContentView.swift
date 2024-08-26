//
//  ContentView.swift
//  socket-io-ios-app
//
//  Created by Kien on 19/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var message: String = ""
    @State private var receivedMessages: [String] = []

    var body: some View {
        VStack(spacing: 20) {
            Text("Socket.IO Chat")
                .font(.largeTitle)

            TextField("Enter your message", text: $message)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                sendMessage()
            }) {
                Text("Send")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(receivedMessages, id: \.self) { msg in
                        Text(msg)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .padding(.bottom, 5)
                    }
                }
                .padding()
            }
        }
        .padding()
        .onAppear {
            setupSocketConnection()
        }
    }

    private func setupSocketConnection() {
        RTCManager.shared.connect()

        RTCManager.shared.socket.on("message") { (dataArray, ack) in
            if let message = dataArray[0] as? String {
                DispatchQueue.main.async {
                    receivedMessages.append(message)
                }
            }
        }
    }

    private func sendMessage() {
        if !message.isEmpty {
            RTCManager.shared.sendMessage(message)
            message = ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
