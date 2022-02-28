import Foundation

public protocol StringParsable {
	init?(_ string: String)
}

public enum StringDecodingError<T: StringParsable>: Swift.Error {
	case invalidValue(String)
}

extension UnkeyedDecodingContainer {
	mutating func decodeStringAs<T>(_ type: T.Type) throws -> T where T : Decodable, T : StringParsable {
		let string = try decode(String.self)
		guard let value = T(string) else {
			throw StringDecodingError<T>.invalidValue(string)
		}
		return value
	}
}

extension UnkeyedEncodingContainer {
	mutating func encodeAsString<T>(_ value: T) throws where T : Encodable, T : CustomStringConvertible {
		try encode(value.description)
	}
}

extension Double: StringParsable {}
extension Int: StringParsable {}
