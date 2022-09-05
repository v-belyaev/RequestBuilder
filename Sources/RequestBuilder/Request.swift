import Foundation

public struct Request {
  // MARK: - Public properties

  public var urlRequest: URLRequest {
    return requestWrapper.urlRequest
  }

  // MARK: - Private properties

  private let requestWrapper: URLRequestWrapper
  private let requestComponent: RequestComponent

  // MARK: - init

  public init(@RequestBuilder _ builder: () -> RequestComponent) {
    let requestComponent = builder()
    let requestWrapper = requestComponent.build(URLRequestWrapper.empty)

    self.requestWrapper = requestWrapper
    self.requestComponent = requestComponent
  }

  // MARK: - Public methods

  public func modify(
    @RequestBuilder _ builder: () -> RequestComponent
  ) -> Request {
    let oldComponent = requestComponent
    let newComponent = builder()

    return Request {
      oldComponent
      newComponent
    }
  }
}

// MARK: - Equatable

extension Request: Equatable {
  public static func == (lhs: Request, rhs: Request) -> Bool {
    return lhs.urlRequest == rhs.urlRequest
  }
}

// MARK: - Hashable

extension Request: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(urlRequest)
  }
}
