import UIKit
import NeedleFoundation

public protocol RootDependency: Dependency {
    
}

public final class RootComponent: Component<RootDependency> {
    public func makeView() -> RootViewController {
        return RootViewController()
        
    }
}
