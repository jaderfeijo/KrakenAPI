import Foundation

typealias EquatableCodable = Equatable & Codable

struct JsonValue<T: Codable>: Codable {
	let value: T
}

extension JsonValue: Equatable where T: Equatable {}
