import Foundation

public extension URLSession {
  func dataTask(
    with request: Request,
    completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
  ) -> URLSessionDataTask {
    return dataTask(
      with: request.urlRequest,
      completionHandler: completionHandler
    )
  }

  func dataTask(
    with request: Request
  ) -> URLSessionDataTask {
    return dataTask(
      with: request.urlRequest
    )
  }

  func dataTaskPublisher(
    for request: Request
  ) -> DataTaskPublisher {
    return dataTaskPublisher(
      for: request.urlRequest
    )
  }
}
