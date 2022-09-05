import Foundation

internal extension URL {
  /// Empty URL for empty URLRequest
  static var empty: URL {
    guard let url = URL(string: "https:")
    else { fatalError("Can't init URL from string — \"https:\"") }

    return url
  }
}
