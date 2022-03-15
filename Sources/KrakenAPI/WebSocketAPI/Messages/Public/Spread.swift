import Foundation

extension WebSocketAPI.Messages.Public {
	public struct Spread: Equatable {
		let channelID: Int
		let bid: Bid
		let channelName: String
		let pair: TradingPair
	}
}

extension WebSocketAPI.Messages.Public.Spread {
	public struct Bid: Equatable {
		let bid: Double
		let ask: Double
		let timestamp: Double
		let bidVolume: Double
		let askVolume: Double
	}
}

// MARK: - Codable Conformance -

extension WebSocketAPI.Messages.Public.Spread: Codable {
	public init(from decoder: Decoder) throws {
		typealias TradingPair = WebSocketAPI.Messages.Public.TradingPair
		var container = try decoder.unkeyedContainer()
		self.channelID = try container.decode(Int.self)
		self.bid = try container.decode(Bid.self)
		self.channelName = try container.decode(String.self)
		self.pair = try container.decode(TradingPair.self)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.unkeyedContainer()
		try container.encode(channelID)
		try container.encode(bid)
		try container.encode(channelName)
		try container.encode(pair)
	}
}

extension WebSocketAPI.Messages.Public.Spread.Bid: Codable {
	public init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()
		self.bid = try container.decode(StringWrapped<Double>.self)
		self.ask = try container.decode(StringWrapped<Double>.self)
		self.timestamp = try container.decode(StringWrapped<Double>.self)
		self.bidVolume = try container.decode(StringWrapped<Double>.self)
		self.askVolume = try container.decode(StringWrapped<Double>.self)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.unkeyedContainer()
		try container.encode(bid, as: StringWrapped<Double>.self)
		try container.encode(ask, as: StringWrapped<Double>.self)
		try container.encode(timestamp, as: StringWrapped<Double>.self)
		try container.encode(bidVolume, as: StringWrapped<Double>.self)
		try container.encode(askVolume, as: StringWrapped<Double>.self)
	}
}
