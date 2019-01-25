//
//  Theme.swift
//
//  Created by Hans on 2019-01-25.
//  Copyright © 2018 Hans. All rights reserved.
//

import Foundation
import UIKit

class Theme: NSObject {
	
	let main: UIColor
	let secondary: UIColor
	let rule: UIColor
	let text: UIColor
	let name: String
	
	let yellow: UIColor
	let red: UIColor
	let magenta: UIColor
	let blue: UIColor
	let cyan: UIColor
	let green: UIColor
	
	let grey: UIColor
	
	init(named themeName: String, with text_: UIColor, on main_: UIColor, colors yellow_: UIColor, _ red_: UIColor, _ magenta_: UIColor, _ blue_: UIColor, _ cyan_: UIColor, _ green_: UIColor, grey grey_: UIColor) {
		
		name = themeName
		text = text_
		main = main_
		secondary = main.softer()
		rule = secondary.softer()
		
		yellow = yellow_
		red = red_
		magenta = magenta_
		blue = blue_
		cyan = cyan_
		green = green_
		
		grey = grey_
		
		super.init()
		
//		Theme.available[themeName] = self
	}
	
	convenience init(named name: String, with text: Int, on main: Int, colors yellow_: Int, _ red_: Int, _ magenta_: Int,_ blue_: Int, _ cyan_: Int, _ green_: Int, grey grey_: Int) {
		self.init(named: name, with: UIColor(rgb: text), on: UIColor(rgb: main), colors: UIColor(rgb: yellow_), UIColor(rgb: red_), UIColor(rgb: magenta_), UIColor(rgb: blue_), UIColor(rgb: cyan_), UIColor(rgb: green_), grey: UIColor(rgb: grey_))
	}
	
	func isDark() -> Bool {
//		colorMain.v
		return main.isDark()
	}
	
	static func named(_ name: String) -> Theme {
		if available.keys.contains(name) {
			return available[name]!
		}
		return .defaultTheme
	}
	
	func colors() -> [UIColor] {
		return [yellow, red, magenta, blue, cyan, green, grey]
	}
	
	func isMono() -> Bool {
		var count = 0
		for color in colors() {
			if color == text {
				count += 1
			}
		}
		return count > 3
	}
	
	static let solarizedDark = Theme(named: "Solarized Dark", with: 0x93a1a1, on: 0x002b36, colors: 0xb58900, 0xdc322f, 0xd33682, 0x268bd2, 0x2aa198, 0x859900, grey: 0x586e75)
	
	static let solarizedLight = Theme(named: "Solarized Light", with: 0x586e75, on: 0xfdf6e3, colors: 0xb58900, 0xdc322f, 0xd33682, 0x268bd2, 0x2aa198, 0x859900, grey: 0x93a1a1)
	
	static let tomorrowLight = Theme(named: "Tomorrow", with: 0x373b41, on: 0xffffff, colors: 0xf0c674, 0xcc6666, 0xb294bb, 0x81a2be, 0x8abeb7, 0xb5bd68, grey: 0x969896)
	
	static let tomorrowDark = Theme(named: "Tomorrow Night", with: 0xc5c8c6, on: 0x1d1f21, colors: 0xf0c674, 0xcc6666, 0xb294bb, 0x81a2be, 0x8abeb7, 0xb5bd68, grey: 0x969896)
	
	static let monokaiDark = Theme(named: "Monokai Dark", with: 0xf8f8f2, on: 0x272822, colors: 0xf4bf75, 0xf92672, 0xae81ff, 0x66d9ef, 0xa1efe4, 0xa6e22e, grey: 0x75715e)
	
	static let monokaiLight = Theme(named: "Monokai Light", with: 0x49483e, on: 0xf9f8f5, colors: 0xf4bf75, 0xf92672, 0xae81ff, 0x66d9ef, 0xa1efe4, 0xa6e22e, grey: 0x75715e)
	
	static let monoDark = Theme(named: "Mono Dark", with: 0xffffff, on: 0x000000, colors: 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, grey: 0xffffff)
	
	static let monoLight = Theme(named: "Mono Light", with: 0x000000, on: 0xffffff, colors: 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, grey: 0x000000)
	
	static let monoGreen = Theme(named: "Mono Green", with: 0x00ff00, on: 0x000000, colors: 0x00ff00, 0x00ff00, 0x00ff00, 0x00ff00, 0x00ff00, 0x00ff00, grey: 0x00ff00)
	
	static let darcula = Theme(named: "Darcula", with: 0xf8f8f2, on: 0x282a36, colors: 0xf1fa8c, 0xff5555, 0xff79c6, 0x6272a4, 0x8be9fd, 0x50fa7b, grey: 0xf8f8f2)
	
	static let defaultTheme = Theme.solarizedDark
	
	static var available: [String: Theme] = [
		Theme.solarizedDark.name: Theme.solarizedDark,
		Theme.solarizedLight.name: Theme.solarizedLight,
		Theme.tomorrowLight.name: Theme.tomorrowLight,
		Theme.tomorrowDark.name: Theme.tomorrowDark,
		Theme.monokaiDark.name: Theme.monokaiDark,
		Theme.monokaiLight.name: Theme.monokaiLight,
		Theme.monoDark.name: Theme.monoDark,
		Theme.monoLight.name: Theme.monoLight,
		Theme.monoGreen.name: Theme.monoGreen,
		Theme.darcula.name: Theme.darcula,
	]
}

extension UIColor {
	func lightness() -> CGFloat {
		var redcomponent: CGFloat = 0
		var greencomponent: CGFloat = 0
		var bluecomponent: CGFloat = 0
		var alphacomponent: CGFloat = 0
		self.getRed(&redcomponent, green: &greencomponent, blue: &bluecomponent, alpha: &alphacomponent)
		return 0.2126 * redcomponent + 0.7152 * greencomponent + 0.0722 * bluecomponent;
	}
	
	func isDark() -> Bool {
		return lightness() < 0.5
	}
	
	func toHex() -> Int {
		guard let components = cgColor.components, components.count >= 3 else {
			return 0x000000
		}
		
		let r = Float(components[0])
		let g = Float(components[1])
		let b = Float(components[2])
		
		return lroundf(r * 255) * 0x010000 + lroundf(g * 255) * 0x000100 + lroundf(b * 255)
	}
	
	func softer() -> UIColor {
		return UIColor(rgb: self.toHex().softer())
	}
	
	convenience init(red: Int, green: Int, blue: Int) {
		assert(red >= 0 && red <= 255, "Invalid red component")
		assert(green >= 0 && green <= 255, "Invalid green component")
		assert(blue >= 0 && blue <= 255, "Invalid blue component")
		
		self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
	}
	
	convenience init(rgb: Int) {
		self.init(
			red: (rgb >> 16) & 0xFF,
			green: (rgb >> 8) & 0xFF,
			blue: rgb & 0xFF
		)
	}
}

extension Int {
	func softer() -> Int {
		if UIColor(rgb: self).isDark() {
			let a: Int = self + 0x222222
			let b: Int = 0xffffff - (0xffffff - self) / 2
			if a < b {
				return a
			} else {
				return b
			}
		} else {
			let a: Int = self - 0x222222
			let b: Int = self / 2
			if a > b {
				return a
			} else {
				return b
			}
		}
	}
}
