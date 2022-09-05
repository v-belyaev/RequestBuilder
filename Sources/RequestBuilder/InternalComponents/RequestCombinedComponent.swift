import Foundation

internal struct RequestCombinedComponent: RequestComponent {
  private let components: [RequestComponent]

  internal init(_ components: RequestComponent...) {
    self.components = components
  }

  internal init(_ components: [RequestComponent]) {
    self.components = components
  }

  internal func build(
    _ requestWrapper: URLRequestWrapper
  ) -> URLRequestWrapper {
    var tempWrapper = requestWrapper

    components.forEach {
      let temp = $0.build(tempWrapper)
      tempWrapper = temp
    }

    return tempWrapper
  }
}
