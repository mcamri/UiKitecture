import UIKit
public struct BaseModule {
    public private(set) var text = "Hello, World!"

    public init() {
    }
}

public protocol ModuleItem {
  var view: UIViewController { get }
}
