import Foundation

@resultBuilder
public struct RequestBuilder {
  public static func buildBlock(
    _ components: RequestComponent...
  ) -> RequestComponent {
    return RequestCombinedComponent(components)
  }

  public static func buildOptional(
    _ component: RequestComponent?
  ) -> RequestComponent {
    return component ?? RequestEmptyComponent()
  }

  public static func buildArray(
    _ components: [RequestComponent]
  ) -> RequestComponent {
    return RequestCombinedComponent(components)
  }

  public static func buildEither(
    first component: RequestComponent
  ) -> RequestComponent {
    return component
  }

  public static func buildEither(
    second component: RequestComponent
  ) -> RequestComponent {
    return component
  }
}
