import Foundation

public extension Header {
  enum MediaType: Hashable, ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    
    case json
    case xml
    case text
    case form
    case custom(String)
    
    public init(stringLiteral value: String) {
      self = .custom(value)
    }
  }
}

// MARK: - RawValue

public extension Header.MediaType {
  var rawValue: String {
    switch self {
    case .json:
      return "application/json"
    case .xml:
      return "application/xml"
    case .form:
      return "application/x-www-form-urlencoded"
    case .text:
      return "text/plain"
    case let .custom(string):
      return string
    }
  }
}
