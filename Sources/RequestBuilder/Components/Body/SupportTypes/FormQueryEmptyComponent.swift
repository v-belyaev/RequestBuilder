import Foundation

internal struct FormQueryEmptyComponent: FormQueryComponent {
  internal func build(
    _ queryWrapper: URLQueryItemWrapper
  ) -> URLQueryItemWrapper {
    return queryWrapper
  }
}

extension Optional: FormQueryComponent where Wrapped: FormQueryComponent {
  public func build(_ queryWrapper: URLQueryItemWrapper) -> URLQueryItemWrapper {
    switch self {
    case .none:
      return FormQueryEmptyComponent().build(queryWrapper)
    case let .some(wrapped):
      return wrapped.build(queryWrapper)
    }
  }
}
