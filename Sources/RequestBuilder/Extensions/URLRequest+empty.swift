import Foundation

internal extension URLRequest {
  /// Empty URLRequest for build
  static var empty: URLRequest {
    let url = URL.empty
    let urlRequest = URLRequest(url: url)
    return urlRequest
  }
}
