import Foundation

extension WebSocketAPI.Messages.Public {
	public struct Candle: Equatable {
		let channelID: Int
		let data: CandleData
		let channelName: String
		let pair: TradingPair
	}
}

extension WebSocketAPI.Messages.Public.Candle {
	public struct CandleData: Equatable {
		let time: Double
		let endTime: Double
		let open: Double
		let high: Double
		let low: Double
		let close: Double
		let averagePrice: Double
		let volume: Double
		let count: Int
	}
}

// MARK: - Codable Conformance -

extension WebSocketAPI.Messages.Public.Candle.CandleData: Codable {
	public init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()
		self.time = try container.decode(StringWrapped<Double>.self)
		self.endTime = try container.decode(StringWrapped<Double>.self)
		self.open = try container.decode(StringWrapped<Double>.self)
		self.high = try container.decode(StringWrapped<Double>.self)
		self.low = try container.decode(StringWrapped<Double>.self)
		self.close = try container.decode(StringWrapped<Double>.self)
		self.averagePrice = try container.decode(StringWrapped<Double>.self)
		self.volume = try container.decode(StringWrapped<Double>.self)
		self.count = try container.decode(Int.self)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.unkeyedContainer()
		try container.encode(time, as: StringWrapped<Double>.self)
		try container.encode(endTime, as: StringWrapped<Double>.self)
		try container.encode(open, as: StringWrapped<Double>.self)
		try container.encode(high, as: StringWrapped<Double>.self)
		try container.encode(low, as: StringWrapped<Double>.self)
		try container.encode(close, as: StringWrapped<Double>.self)
		try container.encode(averagePrice, as: StringWrapped<Double>.self)
		try container.encode(volume, as: StringWrapped<Double>.self)
		try container.encode(count)
	}
}
