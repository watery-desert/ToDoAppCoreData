//
//  Extensions.swift
//  ToDoAppCoreData
//
//  Created by Ahmed on 02/01/22.
//

import SwiftUI


///  This extenstion will help to use hex code of color
extension Color {
     init(hex: UInt, opacity: Double = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            opacity: opacity
        )
    }
}
