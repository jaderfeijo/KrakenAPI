import Foundation

extension Configuration {
	public enum Access {
		case authenticated(key: String)
		case `public`
	}
}

