//
//  Created by Tomaz Kragelj on 21.05.17.
//  Copyright © 2017 Gentle Bytes. All rights reserved.
//

import UIKit
import SwiftRichString

final class Styles {
	
	/**
	Converts the given string into attributed string using the given styles.
	*/
	static func text(from string: String, styles: [Style]) -> NSAttributedString? {
		let markup = try! MarkupString(source: string, styles: styles)
		return markup.render(withStyles: styles)
	}
	
	/**
	Returns the style using default size.
	*/
	static func style(name: String? = nil, appearance: Appearance, size: Size) -> Style {
		return style(name: name, appearance: appearance, size: size.fontSize)
	}

	/**
	Returns the style for custom size.
	*/
	static func style(name: String? = nil, appearance: Appearance, size: CGFloat) -> Style {
		return Style(name ?? appearance.styleName, {
			$0.font = FontAttribute(font: UIFont.systemFont(ofSize: size, weight: appearance.fontWeight))!
			$0.color = appearance.fontColor
		})
	}

	/**
	Element apperance.
	*/
	struct Appearance: OptionSet {
		let rawValue: Int
		
		static let light = Appearance(rawValue: 1 << 0)
		static let emphasized = Appearance(rawValue: 1 << 1)
		static let semiEmphasized = Appearance(rawValue: 1 << 2)
		static let inverted = Appearance(rawValue: 1 << 3)
		static let warning = Appearance(rawValue: 1 << 4)
		
		var styleName: String {
			if contains(.emphasized) {
				return "emphasized"
			} else if contains(.semiEmphasized) {
				return "semi-emphasized"
			} else {
				return "light"
			}
		}
		
		var fontWeight: CGFloat {
			if contains(.emphasized) || contains(.semiEmphasized) {
				return UIFontWeightMedium
			} else {
				return UIFontWeightUltraLight
			}
		}
		
		var fontColor: UIColor {
			if contains(.inverted) {
				if contains(.warning) {
					return UIColor.yellow
				} else if contains(.emphasized) || contains(.semiEmphasized) {
					return UIColor.white
				} else {
					return UIColor.white.withAlphaComponent(0.6)
				}
			} else {
				if contains(.warning) {
					return UIColor.red
				} else if contains(.emphasized) {
					return UIColor.darkText
				} else {
					return UIColor.lightGray
				}
			}
		}
	}
	
	/**
	Element size.
	*/
	enum Size {
		case title
		case main
		case info
		
		var fontSize: CGFloat {
			switch self {
			case .title: return UIDevice.iPhone ? 19 : 22
			case .main: return UIDevice.iPhone ? 17 : 19
			case .info: return UIDevice.iPhone ? 14 : 16
			}
		}
	}
}

// MARK: - Common styling

extension Styles {

	/**
	Prepares attributed string for delete buttons.
	*/
	static func deleteButtonText(size: Int, valueStyle: Style? = nil, unitStyle: Style? = nil) -> NSAttributedString? {
		if size == 0 {
			return nil
		}
		
		let value = Formatter.size(fromBytes: size)
		
		let usedValueStyle = valueStyle ?? Styles.deleteButtonValueStyle
		let usedUnitStyle = unitStyle ?? Styles.deleteButtonUnitStyle
		
		let result = NSMutableAttributedString()
		result.append(value.value.set(style: usedValueStyle))
		result.append(value.unit.set(style: usedUnitStyle))
		return result
	}

	private static let deleteButtonValueStyle = Styles.style(appearance: [.emphasized, .warning], size: .main)
	private static let deleteButtonUnitStyle = Styles.style(appearance: [.light, .warning], size: .main)
}
