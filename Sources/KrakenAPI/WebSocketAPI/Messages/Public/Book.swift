import Foundation

extension WebSocketAPI.Messages.Public {
	public struct Book: Equatable {
		let channelID: Int
		let asks: [Price]
		let bids: [Price]
		let channelName: String
		let pair: [TradingPair]
	}
}

extension WebSocketAPI.Messages.Public.Book {
	public struct Price: Equatable {
		let price: Double
		let volume: Double
		let timestamp: Double
	}
}

// MARK: - Codable Conformance -

extension WebSocketAPI.Messages.Public.Book.Price: Codable {
	public init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()
		self.price = try container.decode(StringWrapped<Double>.self)
		self.volume = try container.decode(StringWrapped<Double>.self)
		self.timestamp = try container.decode(StringWrapped<Double>.self)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.unkeyedContainer()
		try container.encode(price, as: StringWrapped<Double>.self)
		try container.encode(volume, as: StringWrapped<Double>.self)
		try container.encode(timestamp, as: StringWrapped<Double>.self)
	}
}
