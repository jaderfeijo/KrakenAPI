import Foundation

extension WebSocketAPI {
	public struct Subscription: Codable {
		public let pair: [TradingPair]
		public let options: Options
	}
}

extension WebSocketAPI.Subscription {
	public struct Options: Codable {
		public let name: Name
		public let depth: Depth?
		public let interval: Interval?
		public let rateCounter: Bool?
		public let snapshot: Bool?
		public let token: String?

		public init(
			name: Name,
			depth: Depth? = nil,
			interval: Interval? = nil,
			rateCounter: Bool? = nil,
			snapshot: Bool? = nil,
			token: String? = nil) {
			self.name = name
			self.depth = depth
			self.interval = interval
			self.rateCounter = rateCounter
			self.snapshot = snapshot
			self.token = token
		}
	}
}

extension WebSocketAPI.Subscription.Options {
	public enum Name: String, Codable {
		case book = "book"
		case ohlc = "ohlc"
		case openOrders = "openOrders"
		case ownTrades = "ownTrades"
		case spread = "spread"
		case ticker = "ticker"
		case trade = "trade"
		case all = "*"
	}
}

extension WebSocketAPI.Subscription.Options {
	public enum Depth: Int, Codable {
		case shallowest = 10
		case shallow = 25
		case medium = 100
		case deep = 500
		case deepest = 1000
	}
}

extension WebSocketAPI.Subscription.Options {
	public enum Interval: Int, Codable {
		case oneMinute = 1
		case fiveMinutes = 5
		case fifteenMinutes = 15
		case thirtyMinutes = 30
		case oneHour = 60
		case fourHours = 240
		case oneDay = 1440
		case oneWeek = 10080
		case fifteenDays = 21600
	}
}
