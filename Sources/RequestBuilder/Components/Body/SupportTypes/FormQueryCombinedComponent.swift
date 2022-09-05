import Foundation

internal struct FormQueryCombinedComponent: FormQueryComponent {
  private let components: [FormQueryComponent]

  internal init(_ components: [FormQueryComponent]) {
    self.components = components
  }

  internal init(_ components: FormQueryComponent...) {
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
