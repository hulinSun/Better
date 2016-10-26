//
//  GCD.swift
//  better
//
//  Created by Hony on 2016/10/26.
//  Copyright © 2016年 Hony. All rights reserved.
//

import Foundation

extension DispatchQueue{
    public func after(delay: TimeInterval, execute closure: @escaping () -> ()) {
        asyncAfter(deadline: .now() + delay, execute: closure)
    }
}
