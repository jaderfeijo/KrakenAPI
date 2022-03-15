import Foundation

extension WebSocketAPI.Messages.Public {
	public struct Book: Equatable {
		let channelID: Int
		let asks: [Price]
		let bids: [Price]
		let channelName: String
		let pair: TradingPair
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

extension WebSocketAPI.Messages.Public.Book: Codable {
	enum CodingKeys: String, CodingKey {
		case asks = "as"
		case bids = "bs"
	}

	public init(from decoder: Decoder) throws {
		typealias TradingPair = WebSocketAPI.Messages.Public.TradingPair
		var container = try decoder.unkeyedContainer()
		self.channelID = try container.decode(Int.self)

		let subcontainer = try container.nestedContainer(keyedBy: CodingKeys.self)
		self.asks = try subcontainer.decode([Price].self, forKey: .asks)
		self.bids = try subcontainer.decode([Price].self, forKey: .bids)

		self.channelName = try container.decode(String.self)
		self.pair = try container.decode(TradingPair.self)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.unkeyedContainer()
		try container.encode(channelID)

		var subcontainer = container.nestedContainer(keyedBy: CodingKeys.self)
		try subcontainer.encode(asks, forKey: .asks)
		try subcontainer.encode(bids, forKey: .bids)

		try container.encode(channelName)
		try container.encode(pair)
	}
}

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
