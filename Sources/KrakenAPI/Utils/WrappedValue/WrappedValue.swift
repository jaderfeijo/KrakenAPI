import Foundation

extension WrappedValue {
	enum ParsingError: Swift.Error {
		case invalidValue(Wrapped)
	}
}

struct WrappedValue<Value, Wrapped> {
	let value: Value
}

// MARK: - Equatable -

extension WrappedValue: Equatable where Value: Equatable { }

// MARK: - Codable -

extension WrappedValue: Codable where Wrapped: Codable, Value: Wrappable, Value.Wrapped == Wrapped {
	init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let wrapped = try container.decode(Wrapped.self)

		guard let value = Value(unwrapping: wrapped) else {
			throw ParsingError.invalidValue(wrapped)
		}

		self.value = value
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(value.wrapped())
	}
}
