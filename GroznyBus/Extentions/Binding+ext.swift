//
//  Binding+ext.swift
//  GroznyBus
//
//  Created by Lukman Makhaev on 28.06.2024.
//

import SwiftUI

extension Binding where Value == Double {
    var asString: Binding<String> {
        Binding<String>(
            get: { String(self.wrappedValue) },
            set: {
                if let value = Double($0) {
                    self.wrappedValue = value
                }
            }
        )
    }
}
