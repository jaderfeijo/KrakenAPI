import Foundation

extension WebSocketAPI {
	public struct SystemStatus: Equatable, Codable {
		public let status: Status
		public let version: String
		public let connectionID: Int?

		public init(
			status: Status,
			version: String,
			connectionID: Int? = nil) {
			self.status = status
			self.version = version
			self.connectionID = connectionID
		}
	}
}

extension WebSocketAPI.SystemStatus {
	public enum Status: String, CaseIterable, Codable {
		case online = "online"
		case maintenance = "maintenance"
		case cancelOnly = "cancel_only"
		case limitOnly = "limit_only"
		case postOnly = "post_only"
	}
}
