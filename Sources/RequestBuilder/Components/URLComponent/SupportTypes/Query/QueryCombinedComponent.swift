import Foundation

internal struct QueryCombinedComponent: QueryComponent {
  private let components: [QueryComponent]

  internal init(_ components: [QueryComponent]) {
    self.components = components
  }

  internal init(_ components: QueryComponent...) {
    self.components = components
  }

  internal func build(
    _ queryWrapper: URLQueryItemWrapper
  ) -> URLQueryItemWrapper {
    var tempWrapper = queryWrapper

    components.forEach {
      let temp = $0.build(tempWrapper)
      tempWrapper = temp
    }

    return tempWrapper
  }
}
