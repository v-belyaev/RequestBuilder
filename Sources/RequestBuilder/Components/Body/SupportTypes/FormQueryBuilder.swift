import Foundation

@resultBuilder
public struct FormQueryBuilder {
  public static func buildBlock(
    _ components: FormQueryComponent...
  ) -> FormQueryComponent {
    return FormQueryCombinedComponent(components)
  }

  public static func buildOptional(
    _ component: FormQueryComponent?
  ) -> FormQueryComponent {
    return component ?? FormQueryEmptyComponent()
  }

  public static func buildArray(
    _ components: [FormQueryComponent]
  ) -> FormQueryComponent {
    return FormQueryCombinedComponent(components)
  }

  public static func buildEither(
    first component: FormQueryComponent
  ) -> FormQueryComponent {
    return component
  }

  public static func buildEither(
    second component: FormQueryComponent
  ) -> FormQueryComponent {
    return component
  }
}
