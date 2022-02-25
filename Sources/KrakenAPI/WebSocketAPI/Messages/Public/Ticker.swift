import Foundation

extension WebSocketAPI.Messages.Public {
	typealias TradingPair = WebSocketAPI.Messages.General.TradingPair

	public struct Ticker {
		let channelID: Int
		let pricing: Pricing
		let channelName: String
		let pair: TradingPair
	}
}

extension WebSocketAPI.Messages.Public.Ticker {
	public struct Pricing {
		let ask: PriceWholeVolume
		let bid: PriceWholeVolume
		let close: Value
		let volume: Value
		let averagePrice: Value
		let numberOfTrades: Value
		let low: Value
		let high: Value
		let open: Value
	}
}

extension WebSocketAPI.Messages.Public.Ticker.Pricing {
	public struct PriceWholeVolume: Codable {
		let price: Double
		let wholeLotVolume: Int
		let lotVolume: Double
	}
}

extension WebSocketAPI.Messages.Public.Ticker.Pricing {
	public struct PriceVolume: Codable, Equatable {
		let price: Double
		let lotVolume: Double
	}
}

extension WebSocketAPI.Messages.Public.Ticker.Pricing {
	public struct Value: Equatable {
		let today: Double
		let last24Hours: Double
	}
}

// MARK: - Codable Conformance -

extension WebSocketAPI.Messages.Public.Ticker: Codable {
	public init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()
		self.channelID = try container.decode(Int.self)
		self.pricing = try container.decode(WebSocketAPI.Messages.Public.Ticker.Pricing.self)
		self.channelName = try container.decode(String.self)
		self.pair = try container.decode(WebSocketAPI.Messages.Public.TradingPair.self)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.unkeyedContainer()
		try container.encode(channelID)
		try container.encode(pricing)
		try container.encode(channelName)
		try container.encode(pair)
	}
}

extension WebSocketAPI.Messages.Public.Ticker.Pricing: Codable {
	enum CodingKeys: String, CodingKey {
		case ask = "a"
		case bid = "b"
		case close = "c"
		case volume = "v"
		case averagePrice = "p"
		case numberOfTrades = "t"
		case low = "l"
		case high = "h"
		case open = "open"
	}
}

extension WebSocketAPI.Messages.Public.Ticker.Pricing.Value: Codable {
	typealias ValueCodable = WebSocketAPI.Messages.Internal.ValueCodable

	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let value = try container.decode(ValueCodable.self)
		self.today = value.a
		self.last24Hours = value.b
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(
			ValueCodable(
				a: today,
				b: last24Hours)
		)
	}
}
