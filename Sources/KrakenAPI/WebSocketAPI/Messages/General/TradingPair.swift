import Foundation

extension WebSocketAPI.Messages.General {
	public struct TradingPair: Equatable {
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

extension WebSocketAPI.Messages.General.TradingPair: Encodable {
	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(a + "/" + b)
	}
}

extension WebSocketAPI.Messages.General.TradingPair: Decodable {
	enum DecodingError: Swift.Error {
		case invalidFormat(value: String)
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let value = try container.decode(String.self)
		let components = value.components(separatedBy: "/")

		guard components.count == 2 else {
			throw DecodingError.invalidFormat(value: value)
		}

		self.a = components[0]
		self.b = components[1]
	}
}
