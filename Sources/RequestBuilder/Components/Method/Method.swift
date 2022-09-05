import Foundation

public struct Method: Hashable {
  public let type: `Type`

  public init(_ type: `Type`) {
    self.type = type
  }

  public enum `Type`: String, Hashable {
    case connect = "CONNECT"
    case delete = "DELETE"
    case get = "GET"
    case head = "HEAD"
    case options = "OPTIONS"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case trace = "TRACE"
  }
}

// MARK: - Method types

public extension Method {
  static var connect: Method {
    return Method(.connect)
  }

  static var delete: Method {
    return Method(.delete)
  }

  static var get: Method {
    return Method(.get)
  }

  static var head: Method {
    return Method(.head)
  }

  static var options: Method {
    return Method(.options)
  }

  static var patch: Method {
    return Method(.patch)
  }

  static var post: Method {
    return Method(.post)
  }

  static var put: Method {
    return Method(.put)
  }

  static var trace: Method {
    return Method(.trace)
  }
}

// MARK: - RequestComponent

extension Method: RequestComponent {
  public func build(
    _ requestWrapper: URLRequestWrapper
  ) -> URLRequestWrapper {
    return requestWrapper.modify(self)
  }
}
