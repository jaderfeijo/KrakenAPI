import Foundation

extension WebSocketAPI.Messages.General {
	struct Ping: Equatable {
		let event: Event = .ping
		let requestId: Int?
	}
}

// MARK: - Codable Conformance -

extension WebSocketAPI.Messages.General.Ping: Codable {
	enum CodingKeys: String, CodingKey {
		case event
		case requestId = "reqid"
	}
}
