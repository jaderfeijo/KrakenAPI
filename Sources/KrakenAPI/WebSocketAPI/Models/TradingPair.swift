import Foundation

extension WebSocketAPI {
	public struct TradingPair: Codable {
		public let a: String
		public let b: String

		public init(
			a: String,
			b: String) {
			self.a = a
			self.b = b
		}
	}
}
