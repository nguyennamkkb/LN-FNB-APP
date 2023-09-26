//
//  Constant.swift
//  BaseApp
//
//  Created by namnl on 24/04/2023.
//

import Foundation
import UIKit
import Printer

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height
let bluetoothPrinterManager = BluetoothPrinterManager()
struct myColor {
    static let blue = UIColor(hex: "#1A72DD")
    static let navy = UIColor(hex: "#2A3256")
    static let grey = UIColor(hex: "#D1D1D1")
    static let greyDrak = UIColor(hex: "#BDBDBD")
    static let red = UIColor(hex: "#F4261A")
    static let MRed = UIColor(hex: "#ee4035")
    static let MOrange = UIColor(hex: "#f37736")
    static let MYellow = UIColor(hex: "#fdf498")
    static let MGreen = UIColor(hex: "#7bc043")
    static let MBlue = UIColor(hex: "#0392CF")

}
struct myCornerRadius {
    static let corner5 = 5.0
    static let corner10 = 10.0
    static let corner14 = 14.0
    static let corner16 = 16.0
    static let corner20 = 20.0
}


enum C: Any {
    enum Color {
        static let Green = UIColor(hex: "#1EA54C")
        static let White = UIColor(hex: "#FFFFFF")
        static let Black = UIColor(hex: "#1E2633")
        static let Navi = UIColor(hex: "#2E3D4A")
        static let Gray = UIColor(hex: "#B1B4BB")
        static let Blue = UIColor(hex: "#1A72DD")
    }
    enum CornerRadius {
        static let corner5 = 5.0
        static let corner10 = 10.0
    }
    enum Screen {
        static let WIDTH = UIScreen.main.bounds.width
        static let HEIGHT = UIScreen.main.bounds.height
    }
}
