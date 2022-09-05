import Foundation

public typealias Headers = [Header]

extension Headers {
  /// Creates an instance from a `[String: String]`. Duplicate case-insensitive names are collapsed into the last name
  /// and value encountered.
  public init(_ dictionary: [String: String]) {
    self.init()
    
    dictionary.forEach {
      update(Header($0.key, value: $0.value))
    }
  }
  
  /// Sort the current instance by header name, case insensitively.
  public mutating func sort() {
    sort {
      $0.name.lowercased() < $1.name.lowercased()
    }
  }
  
  /// Returns an instance sorted by header name.
  ///
  /// - Returns: A copy of the current instance sorted by name.
  public func sorted() -> Headers {
    var headers = self
    headers.sort()
    return headers
  }
  
  public func index(of name: String) -> Headers.Index? {
    guard let index = firstIndex(where: {
      $0.name.lowercased() == name.lowercased()
    }) else { return nil }
    
    return index
  }
  
  /// Case-insensitively find a header's value by name.
  ///
  /// - Parameter name: The name of the header to search for, case-insensitively.
  ///
  /// - Returns:        The value of header, if it exists.
  public func value(for name: String) -> String? {
    guard let index = index(of: name)
    else { return nil }
    
    return self[index].value
  }
  
  /// Case-insensitively updates or appends an `Header` into the instance using the provided `name` and `value`.
  ///
  /// - Parameters:
  ///   - name:  The `Header` name.
  ///   - value: The `Header value.
  public mutating func add(name: String, value: String) {
    update(Header(name, value: value))
  }
  
  /// Case-insensitively updates or appends the provided `Header` into the instance.
  ///
  /// - Parameter header: The `Header` to update or append.
  public mutating func add(_ header: Header) {
    update(header)
  }
  
  /// Case-insensitively updates or appends an `Header` into the instance using the provided `name` and `value`.
  ///
  /// - Parameters:
  ///   - name:  The `Header` name.
  ///   - value: The `Header value.
  public mutating func update(name: String, value: String) {
    update(Header(name, value: value))
  }
  
  /// Case-insensitively updates or appends the provided `Header` into the instance.
  ///
  /// - Parameter header: The `HTTPHeader` to update or append.
  public mutating func update(_ header: Header) {
    guard let index = index(of: header.name)
    else {
      append(header)
      return
    }
    
    replaceSubrange(index...index, with: [header])
  }
  
  /// Case-insensitively removes an `Header`, if it exists, from the instance.
  ///
  /// - Parameter name: The name of the `Header` to remove.
  public mutating func remove(name: String) {
    guard let index = self.index(of: name)
    else { return }
    
    remove(at: index)
  }
  
  /// Case-insensitively access the header with the given name.
  ///
  /// - Parameter name: The name of the header.
  public subscript(_ name: String) -> String? {
    get {
      value(for: name)
    }
    set {
      if let value = newValue {
        update(name: name, value: value)
      } else {
        remove(name: name)
      }
    }
  }
  
  /// The dictionary representation of all headers.
  ///
  /// This representation does not preserve the current order of the instance.
  public var dictionary: [String: String] {
    let namesAndValues = map {
      ($0.name, $0.value)
    }
    
    return Dictionary(
      namesAndValues,
      uniquingKeysWith: { _, last in last }
    )
  }
}

// MARK: - ExpressibleByDictionaryLiteral

extension Headers: ExpressibleByDictionaryLiteral {
  public init(dictionaryLiteral elements: (String, String)...) {
    self.init()
    
    elements.forEach {
      update(name: $0.0, value: $0.1)
    }
  }
}

// MARK: - System Type Extensions

extension URLRequest {
  /// Returns `allHTTPHeaderFields` as `Headers`.
  public var headers: Headers {
    get { allHTTPHeaderFields.map(Headers.init) ?? Headers() }
    set { allHTTPHeaderFields = newValue.dictionary }
  }
}

extension HTTPURLResponse {
  /// Returns `allHeaderFields` as `Headers`.
  public var headers: Headers {
    (allHeaderFields as? [String: String])
      .map(Headers.init) ?? Headers()
  }
}

extension URLSessionConfiguration {
  /// Returns `httpAdditionalHeaders` as `Headers`.
  public var headers: Headers {
    get {
      (httpAdditionalHeaders as? [String: String])
        .map(Headers.init) ?? Headers()
    }
    set { httpAdditionalHeaders = newValue.dictionary }
  }
}
