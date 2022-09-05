import Foundation

public struct URLRequestWrapper {
  // MARK: - Internal properties

  internal let method: Method?
  internal let headers: Headers
  internal let urlComponent: URLComponent?
  internal let body: Body?

  internal var urlRequest: URLRequest {
    var urlRequest = URLRequest.empty
    urlRequest.url = urlComponent?.url
    urlRequest.headers = headers
    urlRequest.httpMethod = method?.type.rawValue
    urlRequest.httpBody = body?.data
    return urlRequest
  }

  // MARK: - init

  internal init(
    method: Method? = nil,
    headers: Headers = [],
    urlComponent: URLComponent? = nil,
    body: Body? = nil
  ) {
    self.method = method
    self.headers = headers
    self.urlComponent = urlComponent
    self.body = body
  }

  // MARK: - Internal methods

  internal func modify(_ component: Method) -> URLRequestWrapper {
    return URLRequestWrapper(
      method: component,
      headers: self.headers,
      urlComponent: self.urlComponent,
      body: self.body
    )
  }

  internal func modify(_ component: Header) -> URLRequestWrapper {
    var headers = headers
    headers.append(component)

    return URLRequestWrapper(
      method: self.method,
      headers: headers,
      urlComponent: self.urlComponent,
      body: self.body
    )
  }

  internal func modify(_ component: URLComponent) -> URLRequestWrapper {
    return URLRequestWrapper(
      method: self.method,
      headers: self.headers,
      urlComponent: component,
      body: self.body
    )
  }

  internal func modify(_ component: Body) -> URLRequestWrapper {
    return URLRequestWrapper(
      method: self.method,
      headers: self.headers,
      urlComponent: self.urlComponent,
      body: component
    )
  }
}

// MARK: - URLRequestWrapper empty

internal extension URLRequestWrapper {
  static var empty: URLRequestWrapper {
    return URLRequestWrapper()
  }
}
