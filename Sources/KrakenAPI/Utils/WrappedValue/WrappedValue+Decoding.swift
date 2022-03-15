import Foundation

extension SingleValueDecodingContainer {
	func decode<V, W>(_ type: WrappedValue<V, W>.Type) throws -> V where V: Wrappable, V.Wrapped == W, W: Codable  {
		try decode(type).value
	}
}

extension UnkeyedDecodingContainer {
	mutating func decode<V, W>(_ type: WrappedValue<V, W>.Type) throws -> V where V: Wrappable, V.Wrapped == W, W: Codable  {
		try decode(type).value
	}
}

extension SingleValueEncodingContainer {
	mutating func encode<V, W>(_ value: V, as type: WrappedValue<V, W>.Type) throws where V: Wrappable, V.Wrapped == W, W: Codable {
		try encode(type.init(value: value))
	}
}

extension UnkeyedEncodingContainer {
	mutating func encode<V, W>(_ value: V, as type: WrappedValue<V, W>.Type) throws where V: Wrappable, V.Wrapped == W, W: Codable {
		try encode(type.init(value: value))
	}
}
