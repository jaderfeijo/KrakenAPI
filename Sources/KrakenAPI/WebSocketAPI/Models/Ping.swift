import Foundation

extension WebSocketAPI {
	public enum Message {
		case ping
		case pong
		case heartbeat
		case systemStatus(SystemStatus)
		case subscribe(Subscription)
	}
}
