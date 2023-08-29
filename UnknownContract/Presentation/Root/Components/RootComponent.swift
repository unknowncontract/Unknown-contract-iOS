import UIKit
import NeedleFoundation

public protocol RootDependency: Dependency {
    
    var permissionComponent: PermissionComponent { get }
    
}

public final class RootComponent: Component<RootDependency> {
    
    
    public func makeView() -> IntroViewController {
        return IntroViewController(permissionComponent: dependency.permissionComponent)
        
    }
}
