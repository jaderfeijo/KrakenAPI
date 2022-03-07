import Foundation

extension WebSocketAPI.Messages.Public {
	public struct Trade: Equatable, Codable {
		let channelID: Int
		let info: Info
		let channelName: String
		let pair: TradingPair
	}
}

extension WebSocketAPI.Messages.Public.Trade {
	public struct Info: Equatable {
		let price: Double
		let volume: Double
		let time: Double
		let side: Side
		let orderType: OrderType
		let misc: String
	}
}

extension WebSocketAPI.Messages.Public.Trade.Info {
	public enum Side: String, CaseIterable, Codable {
		case buy = "b"
		case sell = "s"
	}
}

extension WebSocketAPI.Messages.Public.Trade.Info {
	public enum OrderType: String, CaseIterable, Codable {
		case market = "m"
		case limit = "l"
	}
}

// MARK: - Codable Conformance -

extension WebSocketAPI.Messages.Public.Trade.Info: Codable {
	public init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()
		self.price = try container.decode(StringWrapped<Double>.self)
		self.volume = try container.decode(StringWrapped<Double>.self)
		self.time = try container.decode(StringWrapped<Double>.self)
		self.side = try container.decode(Side.self)
		self.orderType = try container.decode(OrderType.self)
		self.misc = try container.decode(String.self)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.unkeyedContainer()
		try container.encode(price, as: StringWrapped<Double>.self)
		try container.encode(volume, as: StringWrapped<Double>.self)
		try container.encode(time, as: StringWrapped<Double>.self)
		try container.encode(side)
		try container.encode(orderType)
		try container.encode(misc)
	}
}
