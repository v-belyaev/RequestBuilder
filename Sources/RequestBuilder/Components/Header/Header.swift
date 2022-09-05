import Foundation

public struct Header: Hashable {
  // MARK: - Public properties

  public let name: String
  public let value: String

  // MARK: - init

  public init(name: String, value: String) {
    self.name = name
    self.value = value
  }

  public init(_ name: String, value: String) {
    self.name = name
    self.value = value
  }

  public init(name: String, _ value: String) {
    self.name = name
    self.value = value
  }

  public init(_ name: String, _ value: String) {
    self.name = name
    self.value = value
  }
}

// MARK: - RequestComponent

extension Header: RequestComponent {
  public func build(
    _ requestWrapper: URLRequestWrapper
  ) -> URLRequestWrapper {
    return requestWrapper.modify(self)
  }
}

// MARK: - Common headers

public extension Header {
  /// Returns an `Accept` header.
  static func accept(_ value: String) -> Header {
    return Header(name: "Accept", value: value)
  }
  
  /// Returns an `Accept-Charset` header.
  static func acceptCharset(_ value: String) -> Header {
    return Header(name: "Accept-Charset", value: value)
  }
  
  /// Returns an `Accept-Language` header.
  static func acceptLanguage(_ value: String) -> Header {
    return Header(name: "Accept-Language", value: value)
  }
  
  /// Returns an `Accept-Encoding` header.
  static func acceptEncoding(_ value: String) -> Header {
    return Header(name: "Accept-Encoding", value: value)
  }
  
  /// Returns an `Authorization` header.
  static func authorization(_ value: String) -> Header {
    return Header(name: "Authorization", value: value)
  }
  
  /// Returns an `Authorization` header.
  static func authorization(_ type: Auth) -> Header {
    return Header(name: "Authorization", value: type.value)
  }
  
  /// Returns a `Cache-Control` header.
  static func cacheControl(_ type: CacheType) -> Header {
    return Header(name: "Cache-Control", value: type.value)
  }
  
  /// Returns a `Content-Disposition` header.
  static func contentDisposition(_ value: String) -> Header {
    return Header(name: "Content-Disposition", value: value)
  }
  
  /// Returns a `Content-Length` header.
  static func contentLength(_ value: Int) -> Header {
    return Header(name: "Content-Length", value: "\(value)")
  }
  
  /// Returns a `Content-Type` header.
  static func contentType(_ value: MediaType) -> Header {
    return Header(name: "Content-Type", value: value.rawValue)
  }
  
  /// Returns a `User-Agent` header.
  static func userAgent(_ value: String) -> Header {
    return Header(name: "User-Agent", value: value)
  }
}
