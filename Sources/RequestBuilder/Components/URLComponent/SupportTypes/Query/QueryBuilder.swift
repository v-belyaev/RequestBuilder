import Foundation

@resultBuilder
public struct QueryBuilder {
  public static func buildBlock(
    _ components: QueryComponent...
  ) -> QueryComponent {
    return QueryCombinedComponent(components)
  }

  public static func buildOptional(
    _ component: QueryComponent?
  ) -> QueryComponent {
    return component ?? QueryEmptyComponent()
  }

  public static func buildArray(
    _ components: [QueryComponent]
  ) -> QueryComponent {
    return QueryCombinedComponent(components)
  }

  public static func buildEither(
    first component: QueryComponent
  ) -> QueryComponent {
    return component
  }

  public static func buildEither(
    second component: QueryComponent
  ) -> QueryComponent {
    return component
  }
}
