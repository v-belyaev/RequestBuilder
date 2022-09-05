import Foundation

public protocol QueryComponent {
  func build(_ queryWrapper: URLQueryItemWrapper) -> URLQueryItemWrapper
}
