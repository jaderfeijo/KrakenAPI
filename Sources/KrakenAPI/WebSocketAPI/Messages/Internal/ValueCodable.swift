import Foundation

extension WebSocketAPI.Messages.Internal {
	struct ValueCodable {
		let a: Double
		let b: Double
	}
}

// MARK: - Codable -

extension WebSocketAPI.Messages.Internal.ValueCodable {
	enum DecodingError: Swift.Error {
		case invalidDoubleString(String)
	}
}

extension WebSocketAPI.Messages.Internal.ValueCodable: Decodable {
	init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()

		let aString = try container.decode(String.self)
		let bString = try container.decode(String.self)

		guard let a = Double(aString) else {
			throw DecodingError.invalidDoubleString(aString)
		}

		guard let b = Double(bString) else {
			throw DecodingError.invalidDoubleString(bString)
		}

		self.init(a: a, b: b)
	}
}

extension WebSocketAPI.Messages.Internal.ValueCodable: Encodable {
	func encode(to encoder: Encoder) throws {
		var container = encoder.unkeyedContainer()
		try container.encode(String(a))
		try container.encode(String(b))
	}
}
