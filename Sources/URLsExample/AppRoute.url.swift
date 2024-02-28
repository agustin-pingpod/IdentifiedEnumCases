import Foundation

extension AppRoute {

  func url(with root: URL) -> URL {
    URL(string: self.urlComponents.joined(separator: "/"), relativeTo: root)!.absoluteURL
  }

  var urlComponents: [String] {
    switch self {
    case .item(let itemRoute):
      [self.kind.rawValue] + itemRoute.urlComponents
    case .home, .about, .shop:
      [self.kind.rawValue]
    }
  }
}

extension ItemRoute {

  var urlComponents: [String] {
    switch self {
    case .filter(let filter):
      switch filter {
      case .all:
        [self.kind.rawValue, filter.kind.rawValue]
      case .substring(let string):
        [self.kind.rawValue, filter.kind.rawValue, string.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!]
      }
    case .new:
      [self.kind.rawValue]
    case .view(let itemId):
      [self.kind.rawValue, itemId.id.uuidString]
    }
  }
}
