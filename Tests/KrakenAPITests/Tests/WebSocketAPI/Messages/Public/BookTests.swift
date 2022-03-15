import XCTest
@testable import KrakenAPI

final class BookTests: XCTestCase {
	typealias Book = WebSocketAPI.Messages.Public.Book

	var encoder: JSONEncoder!
	var decoder: JSONDecoder!

	override func setUpWithError() throws {
		try super.setUpWithError()

		encoder = JSONEncoder()
		decoder = JSONDecoder()

		encoder.outputFormatting = [
			.prettyPrinted,
			.withoutEscapingSlashes
		]
	}

	override func tearDownWithError() throws {
		encoder = nil
		decoder = nil

		try super.tearDownWithError()
	}

	func testEncoding() throws {
		let book = Book(
			channelID: 0,
			asks: [
				.init(
					price: 5541.30001,
					volume: 2.50700001,
					timestamp: 1534614248.123678),
				.init(
					price: 5541.80001,
					volume: 0.33000001,
					timestamp: 1534614098.345543),
				.init(
					price: 5542.70001,
					volume: 0.64700001,
					timestamp: 1534614244.654432)
			],
			bids: [
				.init(
					price: 5541.20001,
					volume: 1.52900001,
					timestamp: 1534614248.765567),
				.init(
					price: 5539.90001,
					volume: 0.30000001,
					timestamp: 1534614241.769871),
				.init(
					price: 5539.50001,
					volume: 5.00000001,
					timestamp: 1534613831.243486)
			],
			channelName: "book-100",
			pair: .init(a: "XBT", b: "USD")
		)
		let data = try encoder.encode(book)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			json,
			"""
			[
			  0,
			  {
			    "as" : [
			      [
			        "5541.30001",
			        "2.50700001",
			        "1534614248.123678"
			      ],
			      [
			        "5541.80001",
			        "0.33000001",
			        "1534614098.345543"
			      ],
			      [
			        "5542.70001",
			        "0.64700001",
			        "1534614244.654432"
			      ]
			    ],
			    "bs" : [
			      [
			        "5541.20001",
			        "1.52900001",
			        "1534614248.765567"
			      ],
			      [
			        "5539.90001",
			        "0.30000001",
			        "1534614241.769871"
			      ],
			      [
			        "5539.50001",
			        "5.00000001",
			        "1534613831.243486"
			      ]
			    ]
			  },
			  "book-100",
			  "XBT/USD"
			]
			"""
		)
	}

	func testDecoding() throws {
		let data = """
		[
			0,
			{
				"as": [
					[
						"5541.30001",
						"2.50700001",
						"1534614248.123678"
					],
					[
						"5541.80001",
						"0.33000001",
						"1534614098.345543"
					],
					[
						"5542.70001",
						"0.64700001",
						"1534614244.654432"
					]
				],
				"bs": [
					[
						"5541.20001",
						"1.52900001",
						"1534614248.765567"
					],
					[
						"5539.90001",
						"0.30000001",
						"1534614241.769870"
					],
					[
						"5539.50001",
						"5.00000001",
						"1534613831.243486"
					]
				]
			},
			"book-100",
			"XBT/USD"
		]
		""".data(using: .utf8)!
		let decoded = try decoder.decode(Book.self, from: data)

		XCTAssertEqual(
			decoded,
			Book(
				channelID: 0,
				asks: [
					.init(
						price: 5541.30001,
						volume: 2.50700001,
						timestamp: 1534614248.123678),
					.init(
						price: 5541.80001,
						volume: 0.33000001,
						timestamp: 1534614098.345543),
					.init(
						price: 5542.70001,
						volume: 0.64700001,
						timestamp: 1534614244.654432)
				],
				bids: [
					.init(
						price: 5541.20001,
						volume: 1.52900001,
						timestamp: 1534614248.765567),
					.init(
						price: 5539.90001,
						volume: 0.30000001,
						timestamp: 1534614241.769870),
					.init(
						price: 5539.50001,
						volume: 5.00000001,
						timestamp: 1534613831.243486)
				],
				channelName: "book-100",
				pair: .init(a: "XBT", b: "USD")
			)
		)
	}
}

final class PriceTests: XCTestCase {
	typealias Price = WebSocketAPI.Messages.Public.Book.Price

	var encoder: JSONEncoder!
	var decoder: JSONDecoder!

	override func setUpWithError() throws {
		try super.setUpWithError()

		encoder = JSONEncoder()
		decoder = JSONDecoder()

		encoder.outputFormatting = .prettyPrinted
	}

	override func tearDownWithError() throws {
		encoder = nil
		decoder = nil

		try super.tearDownWithError()
	}

	func testEncoding() throws {
		let price = Price(
			price: 5541.30001,
			volume: 2.50700001,
			timestamp: 1534614248.123678)
		let data = try encoder.encode(price)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			json,
			"""
			[
			  "5541.30001",
			  "2.50700001",
			  "1534614248.123678"
			]
			"""
		)
	}

	func testDecoding() throws {
		let data = """
		[
			"5541.80001",
			"0.33000001",
			"1534614098.345543"
		]
		""".data(using: .utf8)!
		let decoded = try decoder.decode(Price.self, from: data)

		XCTAssertEqual(
			decoded,
			Price(
				price: 5541.80001,
				volume: 0.33000001,
				timestamp: 1534614098.345543)
		)
	}
}
