import Foundation

public struct FormQuery {
  // MARK: - Properties

  public let name: String
  public let value: String?

  public var item: URLQueryItem {
    return URLQueryItem(
      name: name,
      value: value
    )
  }

  // MARK: - init

  public init(name: String, value: String?) {
    self.name = name
    self.value = value
  }

  public init(_ name: String, value: String?) {
    self.name = name
    self.value = value
  }

  public init(name: String, _ value: String?) {
    self.name = name
    self.value = value
  }

  public init(_ name: String, _ value: String?) {
    self.name = name
    self.value = value
  }
}

// MARK: - FormQueryComponent

extension FormQuery: FormQueryComponent {
  public func build(
    _ queryWrapper: URLQueryItemWrapper
  ) -> URLQueryItemWrapper {
    return queryWrapper.modify(self)
  }
}
