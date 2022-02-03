import Foundation
import ArgumentParser

struct SelfTest: ParsableCommand {
	
	public static let configuration = CommandConfiguration(
		abstract: "Performs various tests against the public Kraken API"
	)
	
	func run() throws {
		print("YAY!!!")
	}
}
