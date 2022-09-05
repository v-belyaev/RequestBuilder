import Foundation

public struct URLComponent {
  // MARK: - Public properties

  public var url: URL? {
    return isURLComponentsStrategy
      ? urlFromURLComponents
      : urlFromString
  }

  // MARK: - Private properties

  private let isURLComponentsStrategy: Bool
  private let urlString: String?

  private var urlFromString: URL? {
    guard let urlString = urlString
    else { return URL.empty }

    return URL(string: urlString)
  }

  private var urlFromURLComponents: URL? {
    return urlComponents.url
  }

  private var urlComponents: URLComponents {
    var components: URLComponents = .init()
    components.scheme = scheme?.rawValue ?? ProtocolType.https.rawValue
    components.port = port

    if let path = path {
      components.path = path
    }

    if let host = host, let subdomain = subdomain {
      components.host = subdomain + "." + host
    } else if let host = host {
      components.host = host
    }

    guard let query = queryComponent
    else { return components }

    let wrapper = query.build(URLQueryItemWrapper.emptyQueries)
    components.queryItems = wrapper.urlQueryItems

    return components
  }

  private var scheme: ProtocolType?
  private var subdomain: String?
  private var host: String?
  private var port: Int?
  private var path: String?
  private var queryComponent: QueryComponent?

  // MARK: - init

  public init(_ string: String) {
    self.isURLComponentsStrategy = false
    self.urlString = string
  }

  public init(_ url: URL?) {
    self.isURLComponentsStrategy = false
    self.urlString = url?.absoluteString
  }

  public init(_ urlComponents: URLComponents) {
    self.isURLComponentsStrategy = false
    self.urlString = urlComponents.url?.absoluteString
  }

  public init() {
    self.isURLComponentsStrategy = true
    self.urlString = nil
  }

  // MARK: - Modifiers

  public func scheme(_ scheme: ProtocolType) -> URLComponent {
    assertIfNeeded()

    var mutatingSelf = self
    mutatingSelf.scheme = scheme

    return mutatingSelf
  }

  public func subdomain(_ subdomain: String?) -> URLComponent {
    guard let subdomain = subdomain,
          subdomain.count > 0
    else { return self }

    assertIfNeeded()

    var mutatingSelf = self
    mutatingSelf.subdomain = subdomain

    return mutatingSelf
  }

  public func host(_ host: String) -> URLComponent {
    assertIfNeeded()

    var mutatingSelf = self
    mutatingSelf.host = host

    return mutatingSelf
  }

  public func port(_ port: Int) -> URLComponent {
    assertIfNeeded()

    var mutatingSelf = self
    mutatingSelf.port = port

    return mutatingSelf
  }

  public func path(_ path: String) -> URLComponent {
    assertIfNeeded()

    var mutatingSelf = self
    mutatingSelf.path = path

    return mutatingSelf
  }

  public func queryItems(
    @QueryBuilder builder: () -> QueryComponent
  ) -> URLComponent {
    assertIfNeeded()

    var mutatingSelf = self
    mutatingSelf.queryComponent = builder()

    return mutatingSelf
  }

  // MARK: - Private methods

  private func assertIfNeeded() {
    guard isURLComponentsStrategy == false
    else { return }

    assertionFailure("Use modifiers builder only with `URLComponent.init()`")
  }
}

// MARK: - RequestComponent

extension URLComponent: RequestComponent {
  public func build(
    _ requestWrapper: URLRequestWrapper
  ) -> URLRequestWrapper {
    return requestWrapper.modify(self)
  }
}
