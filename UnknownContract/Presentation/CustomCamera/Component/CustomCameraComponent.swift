//
//  CustomCameraComponent.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/30.
//


import Foundation
import NeedleFoundation

public protocol CustomCameraDependency: Dependency {
    
}

public final class CustomCameraComponent: Component<CustomCameraDependency> {
    

    
    public func makeView() -> CustomCameraViewController {
        return CustomCameraViewController()
        
    }
}
