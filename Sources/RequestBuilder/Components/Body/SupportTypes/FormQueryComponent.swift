import Foundation

public protocol FormQueryComponent {
  func build(_ queryWrapper: URLQueryItemWrapper) -> URLQueryItemWrapper
}
