import Foundation

public struct Body: Hashable {
  // MARK: - Properties

  public let data: Data?

  // MARK: - init

  public init(data: () -> Data?) {
    self.init(data: data())
  }

  public init(data: Data?) {
    self.data = data
  }

  public init<T: Codable>(json: () -> T) {
    self.init(json: json())
  }

  public init<T: Codable>(json: T) {
    let encoder: JSONEncoder = .init()
    let data = try? encoder.encode(json)

    self.data = data
  }

  public init(form: () -> Form) {
    self.init(form: form())
  }

  public init(form: Form) {
    var components: URLComponents = .init()
    components.queryItems = form.wrapper.urlQueryItems

    self.data = components.query?.data(using: .utf8)
  }
}

// MARK: - RequestComponent

extension Body: RequestComponent {
  public func build(
    _ requestWrapper: URLRequestWrapper
  ) -> URLRequestWrapper {
    return requestWrapper.modify(self)
  }
}
