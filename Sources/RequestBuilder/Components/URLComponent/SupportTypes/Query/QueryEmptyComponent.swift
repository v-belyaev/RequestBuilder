import Foundation

internal struct QueryEmptyComponent: QueryComponent {
  internal func build(
    _ queryWrapper: URLQueryItemWrapper
  ) -> URLQueryItemWrapper {
    return queryWrapper
  }
}

extension Optional: QueryComponent where Wrapped: QueryComponent {
  public func build(_ queryWrapper: URLQueryItemWrapper) -> URLQueryItemWrapper {
    switch self {
    case .none:
      return QueryEmptyComponent().build(queryWrapper)
    case let .some(wrapped):
      return wrapped.build(queryWrapper)
    }
  }
}
