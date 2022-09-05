import Foundation

public extension Header {
  struct CacheType: Hashable {
    public let value: String
    
    public init(value: String) {
      self.value = value
    }
  }
}

// MARK: - Common cache types

public extension Header.CacheType {
  static var noCache: Header.CacheType {
    return Header.CacheType(value: "no-cache")
  }
  
  static var noStore: Header.CacheType {
    return Header.CacheType(value: "no-store")
  }
  
  static var maxStale: Header.CacheType {
    return Header.CacheType(value: "max-stale")
  }
  
  static var noTransform: Header.CacheType {
    return Header.CacheType(value: "no-transform")
  }
  
  static var onlyIfCached: Header.CacheType {
    return Header.CacheType(value: "only-if-cached")
  }
  
  static func maxAge(_ seconds: Int) -> Header.CacheType {
    return Header.CacheType(value: "max-age=\(seconds)")
  }
  
  static func maxStale(_ seconds: Int) -> Header.CacheType {
    return Header.CacheType(value: "max-stale=\(seconds)")
  }
  
  static func minFresh(_ seconds: Int) -> Header.CacheType {
    return Header.CacheType(value: "min-fresh=\(seconds)")
  }
}
