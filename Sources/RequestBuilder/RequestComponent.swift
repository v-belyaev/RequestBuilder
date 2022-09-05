import Foundation

public protocol RequestComponent {
  func build(_ requestWrapper: URLRequestWrapper) -> URLRequestWrapper
}
