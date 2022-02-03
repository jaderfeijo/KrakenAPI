import Foundation
import ArgumentParser

struct Kraken: ParsableCommand {
	static let configuration = CommandConfiguration(
		abstract: "A command line tool for interacting with the Kraken API",
		subcommands: [SelfTest.self])
		
		init() { }
}

Kraken.main()
