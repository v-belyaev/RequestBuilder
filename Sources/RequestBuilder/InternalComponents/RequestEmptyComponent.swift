import Foundation

internal struct RequestEmptyComponent: RequestComponent {
  internal func build(
    _ requestWrapper: URLRequestWrapper
  ) -> URLRequestWrapper {
    return requestWrapper
  }
}

extension Optional: RequestComponent where Wrapped: RequestComponent {
  public func build(
    _ requestWrapper: URLRequestWrapper
  ) -> URLRequestWrapper {
    switch self {
    case .none:
      return RequestEmptyComponent().build(requestWrapper)
    case let .some(wrapped):
      return wrapped.build(requestWrapper)
    }
  }
}
