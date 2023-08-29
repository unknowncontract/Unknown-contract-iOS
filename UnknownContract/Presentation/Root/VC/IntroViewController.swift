//
//  ViewController.swift
//  Unknown contract
//
//  Created by yongbeomkwak on 2023/08/28.
//

import UIKit
import SwiftUI
import SnapKit
import Then

public class IntroViewController: UIViewController {
    
    var permissionComponent: PermissionComponent!
    
    
    init(permissionComponent: PermissionComponent) {
        self.permissionComponent = permissionComponent
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
}

extension IntroViewController {


}


