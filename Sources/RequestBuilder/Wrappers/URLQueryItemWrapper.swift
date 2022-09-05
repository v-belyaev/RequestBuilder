import Foundation

public struct URLQueryItemWrapper {
  // MARK: - Properties

  internal let type: `Type`

  internal var urlQueryItems: [URLQueryItem] {
    switch type {
    case let .urlQueries(queries):
      return queries.map { $0.item }
    case let .formQueries(formQueries):
      return formQueries.map { $0.item }
    }
  }

  // MARK: - init

  internal init(queries: [Query] = []) {
    self.type = .urlQueries(queries)
  }

  internal init(formQueries: [FormQuery] = []) {
    self.type = .formQueries(formQueries)
  }

  // MARK: - Methods

  internal func modify(
    _ query: Query
  ) -> URLQueryItemWrapper {
    switch type {
    case let .urlQueries(queries):
      var queries = queries
      queries.append(query)

      return URLQueryItemWrapper(queries: queries)
    case .formQueries(_):
      return self
    }
  }

  internal func modify(
    _ query: FormQuery
  ) -> URLQueryItemWrapper {
    switch type {
    case .urlQueries(_):
      return self
    case let .formQueries(queries):
      var queries = queries
      queries.append(query)

      return URLQueryItemWrapper(formQueries: queries)
    }
  }
}

// MARK: - Empty

extension URLQueryItemWrapper {
  static var emptyQueries: URLQueryItemWrapper {
    return URLQueryItemWrapper(queries: [])
  }

  static var emptyFormQueries: URLQueryItemWrapper {
    return URLQueryItemWrapper(formQueries: [])
  }
}

// MARK: - `Type`

extension URLQueryItemWrapper {
  enum `Type` {
    case urlQueries([Query])
    case formQueries([FormQuery])
  }
}
