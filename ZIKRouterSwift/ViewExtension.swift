//
//  ViewExtension.swift
//  ZIKRouterSwift
//
//  Created by zuik on 2017/10/23.
//  Copyright © 2017 zuik. All rights reserved.
//

import Foundation
import ZIKRouter

extension UIViewController: NamespaceWrappable { }
public extension TypeWrapperProtocol where WrappedType: UIViewController {
    public var routed: Bool {
        return wrappedValue.zix_routed
    }
}

extension UIView: NamespaceWrappable { }
public extension TypeWrapperProtocol where WrappedType: UIView {
    public var routed: Bool {
        return wrappedValue.zix_routed
    }
}
