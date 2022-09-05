import Foundation

public struct Form {
  // MARK: - Properties

  internal let formQuery: FormQueryComponent
  internal let wrapper: URLQueryItemWrapper

  // MARK: - init

  public init(
    @FormQueryBuilder builder: () -> FormQueryComponent
  ) {
    let formQuery = builder()
    let wrapper = formQuery.build(URLQueryItemWrapper.emptyFormQueries)

    self.formQuery = formQuery
    self.wrapper = wrapper
  }
}
