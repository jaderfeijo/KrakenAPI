import Foundation

protocol Wrappable {
	associatedtype Wrapped
	init?(unwrapping wrapped: Wrapped)
	func wrapped() -> Wrapped
}
