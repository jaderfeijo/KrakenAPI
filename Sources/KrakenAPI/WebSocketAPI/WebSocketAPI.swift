import Foundation
import WebSocket

public class WebSocketAPI {

	private lazy var socket: WebSocket = {
		let socket = WebSocket()
		observe(socket)
		return socket
	}()
		
	public let configuration: Configuration

	public init(configuration: Configuration) {
		self.configuration = configuration
	}
}

public extension WebSocketAPI {
	
	var isConnected: Bool {
		socket.isConnected
	}

	func connect() {
		guard let url = URL(string: "wss://\(configuration.websocketHostname)") else {
			fatalError("Unable to form websocket URL from hostname: \(configuration.websocketHostname)")
		}
		print("Connecting to \(url)...")
		socket.connect(url: url)
	}
}

// MARK: - Private -

private extension WebSocketAPI {
	func observe(_ socket: WebSocket) {
		socket.onConnected = { ws in
			print("WS -> Connected...")
		}
		
		socket.onError = { error, ws in
			print("WS -> Error '\(error)'")
		}
		
		socket.onPing = { ws in
			print("WS -> PING!")
		}
		
		socket.onPong = { ws in
			print("WS -> PONG!")
		}
		
		socket.onData = { data, ws in
			switch data {
			case .text(let message):
				print("WS -> Message -> \(message)")
			case .binary(let data):
				print("WS -> Data -> \(String(decoding: data, as: UTF8.self))")
			}	
		}
		
		socket.onDisconnected = { errorCode, ws in
			print("WS -> Disconnected! -> [\(errorCode)]")
		}
		
		print("Observing websocket...")
	}
}
