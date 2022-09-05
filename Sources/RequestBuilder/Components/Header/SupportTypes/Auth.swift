import Foundation

public extension Header {
  struct Auth: Hashable {
    public let type: `Type`
    public let key: String
    
    public var value: String {
      return "\(type.rawValue) \(key)"
    }
    
    public init(_ type: `Type`, key: String) {
      self.type = type
      self.key = key
    }
    
    public enum `Type`: String, Hashable {
      case basic = "Basic"
      case bearer = "Bearer"
    }
  }
}

// MARK: - Common auth

public extension Header.Auth {
  /// Authenticates using `username` and `password` directly
  static func basic(username: String, password: String) -> Header.Auth {
    return Header.Auth(
      .basic,
      key: Data("\(username):\(password)".utf8)
        .base64EncodedString()
    )
  }
  
  /// Authenticates using a `token`
  static func bearer(_ token: String) -> Header.Auth {
    return Header.Auth(.bearer, key: token)
  }
}
