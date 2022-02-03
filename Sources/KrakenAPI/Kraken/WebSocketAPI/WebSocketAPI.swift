import Foundation
import WebSocket

public extension Kraken {
	class WebSocketAPI {
	
		private lazy var socket: WebSocket = {
			let socket = WebSocket()
			observe(socket)
			return socket
		}()
		
		public let configuration: Configuration

		public init(configuration: Configuration) {
			self.configuration = configuration
		}
		
		func connect() {
			guard let url = URL(string: "wss://\(configuration.websocketHostname)") else {
				fatalError("Unable to form websocket URL from hostname: \(configuration.websocketHostname)")
			}
			socket.connect(url: url)
		}
	}
}


// MARK: - Private -

private extension Kraken.WebSocketAPI {
	func observe(_ socket: WebSocket) {
		print("Observing websocket...")
	}
}
