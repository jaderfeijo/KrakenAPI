import Foundation

typealias EquatableCodable = Equatable & Codable

struct JsonValue<T: EquatableCodable>: EquatableCodable {
	let value: T
}
