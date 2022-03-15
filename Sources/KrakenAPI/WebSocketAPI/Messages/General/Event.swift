import Foundation

extension WebSocketAPI.Messages.General {
	public enum Event: String, CaseIterable, Codable {
		case ping
		case pong
		case heartbeat
		case systemStatus
		case subscribe
		case unsubscribe
		case subscriptionStatus
	}
}
