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
	public struct Pricing: Equatable {
		let ask: PriceWholeVolume
		let bid: PriceWholeVolume
		let close: PriceVolume
		let volume: DecimalValuePair
		let averagePrice: DecimalValuePair
		let numberOfTrades: IntegerValuePair
		let low: DecimalValuePair
		let high: DecimalValuePair
		let open: DecimalValuePair
	}
}

extension WebSocketAPI.Messages.Public.Ticker.Pricing {
	public struct PriceWholeVolume: Equatable {
		let price: Double
		let wholeLotVolume: Int
		let lotVolume: Double
	}
}

extension WebSocketAPI.Messages.Public.Ticker.Pricing {
	public struct PriceVolume: Equatable {
		let price: Double
		let lotVolume: Double
	}
}

extension WebSocketAPI.Messages.Public.Ticker.Pricing {
	public struct IntegerValuePair: Equatable {
		let today: Int
		let last24Hours: Int
	}
}

extension WebSocketAPI.Messages.Public.Ticker.Pricing {
	public struct DecimalValuePair: Equatable {
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
		case open = "o"
	}
}

extension WebSocketAPI.Messages.Public.Ticker.Pricing.PriceWholeVolume: Codable {
	public init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()

		self.price = try container.decodeStringAs(Double.self)
		self.wholeLotVolume = try container.decode(Int.self)
		self.lotVolume = try container.decodeStringAs(Double.self)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.unkeyedContainer()
		try container.encodeAsString(price)
		try container.encode(wholeLotVolume)
		try container.encodeAsString(lotVolume)
	}
}

extension WebSocketAPI.Messages.Public.Ticker.Pricing.PriceVolume: Codable {
	public init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()
		self.price = try container.decodeStringAs(Double.self)
		self.lotVolume = try container.decodeStringAs(Double.self)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.unkeyedContainer()
		try container.encodeAsString(price)
		try container.encodeAsString(lotVolume)
	}
}

extension WebSocketAPI.Messages.Public.Ticker.Pricing.IntegerValuePair: Codable {
	public init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()
		self.today = try container.decode(Int.self)
		self.last24Hours = try container.decode(Int.self)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.unkeyedContainer()
		try container.encode(today)
		try container.encode(last24Hours)
	}
}

extension WebSocketAPI.Messages.Public.Ticker.Pricing.DecimalValuePair: Codable {
	public init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()
		self.today = try container.decodeStringAs(Double.self)
		self.last24Hours = try container.decodeStringAs(Double.self)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.unkeyedContainer()
		try container.encodeAsString(today)
		try container.encodeAsString(last24Hours)
	}
}
