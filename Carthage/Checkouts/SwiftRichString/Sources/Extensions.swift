//
//  Extensions.swift
//  SwiftRichString
//  Elegant & Painless Attributed Strings Management Library in Swift
//
//  Created by Daniele Margutti.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//
//	Web: http://www.danielemargutti.com
//	Email: hello@danielemargutti.com
//	Twitter: @danielemargutti
//
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.

import Foundation

//MARK: Marge Style Instances

public func + (lhs: [Style]?, rhs: [Style]?) -> [Style] {
	var items: [Style] = []
	if let lhs = lhs { items.append(contentsOf: lhs) }
	if let rhs = rhs { items.append(contentsOf: rhs) }
	return items.uniqueElements
}

//MARK: Unique Elements in Array

public extension Sequence where Iterator.Element: Hashable {

	/// Generate a new unique elements array from an array of elements which support Hashable protocol
	var uniqueElements: [Iterator.Element] {
		return Array(
			Set(self)
		)
	}
}

public extension Sequence where Iterator.Element: Equatable {

	/// Generate a new unique elements array from an array of elements which support Equatable protocol
	var uniqueElements: [Iterator.Element] {
		return self.reduce([]) { uniqueElements, element in
			uniqueElements.contains(element) ? uniqueElements : uniqueElements + [element]
		}
	}
	
}

//MARK: Array Extension (Style)

public extension Array where Element: Style {
	
	/// Return the index and the instance of the first default Style defined in an array of Style
	///
	/// - Returns: tuple of index+instance or nil if not present
	internal func defaultStyle() -> (index: Int?, item: Style?) {
		let defaultIndex = self.index(where: {
			if case .default = $0.name { return true }
			return false
		})
		if let defaultIndex = defaultIndex {
			return (defaultIndex,self[defaultIndex])
		}
		return (nil,nil)
	}
	
	/// Generate a new attributes dictionary, merge of the attributes from a list of Style
	/// Array is generated by setting as initial style dictionary the default style (if present into the array)
	/// Any other Style is applied and replace existing key in the same order as passed
	internal var attributesDictionary: [String: Any] {
		guard self.count > 1 else {
			return (self.first?.attributes ?? [:])
		}
		let (_,defStyle) = self.defaultStyle()
		var dictionaries: [String: Any] = defStyle?.attributes ?? [:]
		self.forEach {
			if defStyle != $0 {
				dictionaries.unionInPlace(dictionary: $0.attributes)
			}
		}
		return dictionaries
	}
	
}

//MARK: Dictionary Extension

extension Dictionary {
	
	/// Mutate passed dictionary my adding items from another dictionary
	///
	/// - Parameter dictionary: dictionary to append, existing keys are replaced if collide
	mutating func unionInPlace(
		dictionary: Dictionary<Key, Value>) {
		for (key, value) in dictionary {
			self[key] = value
		}
	}
}

/// Merge two arrays by replacing existing lhs values with rhs values when keys collides
///
/// - Parameters:
///   - lhs: lhs dictionary
///   - rhs: rhs dictionary
/// - Returns: merged dictionary
func +<Key, Value> (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
	var result = lhs
	rhs.forEach{ result[$0] = $1 }
	return result
}

//MARK: Concatenate MarkupString

/// Sum two MarkupString and produce a new string sum of both passed.
/// Remember: [Style] associated with lhs will be merged with [Style] associated with rhs string and
/// may be replaced when name is the same between two Styles.
///
/// - Parameters:
///   - lhs: left MarkupString
///   - rhs: right MarkupString
/// - Returns: a new MarkupString with the content of both lhs and rhs strings and with merged styles
public func + (lhs: MarkupString, rhs: MarkupString) throws -> MarkupString {
	let markupString = try MarkupString(source: lhs.string + rhs.string) // concatenate the content
	// sum styles between lhs and rhs (rhs may replace existing lhs's styles)
	markupString.styles = lhs.styles + rhs.styles
	return markupString
}


//MARK: ShadowAttribute

public struct ShadowAttribute {
	
	/// The offset values of the shadow.
	/// This property contains the horizontal and vertical offset values, specified using the width and height fields of the CGSize data type.
	// These offsets are measured using the default user coordinate space and are not affected by custom transformations.
	/// This means that positive values always extend down and to the right from the user's perspective.
	public var offset: CGSize {
		set { self.shadow.shadowOffset = newValue }
		get { return self.shadow.shadowOffset }
	}
	
	/// The blur radius of the shadow.
	/// This property contains the blur radius, as measured in the default user coordinate space.
	/// A value of 0 indicates no blur, while larger values produce correspondingly larger blurring.
	/// This value must not be negative. The default value is 0.
	public var blurRadius: CGFloat {
		set { self.shadow.shadowBlurRadius = newValue }
		get { return self.shadow.shadowBlurRadius }
	}
	
	/// The color of the shadow.
	/// The default shadow color is black with an alpha of 1/3. If you set this property to nil, the shadow is not drawn.
	/// The color you specify must be convertible to an RGBA color and may contain alpha information.
	public var color: UIColor? {
		set { self.shadow.shadowColor = newValue }
		get { return self.shadow.shadowColor as? UIColor }
	}
	
	/// Private cached object
	private var shadow: NSShadow = NSShadow()
	
	/// Create a new shadow
	///
	/// - Parameters:
	///   - color: color of the shadow
	///   - radius: radius of the shadow
	///   - offset: offset of the shadow
	public init(color: UIColor, radius: CGFloat? = nil, offset: CGSize? = nil) {
		self.color = color
		self.blurRadius = radius ?? 0.0
		self.offset = offset ?? CGSize.zero
	}
	
	/// Init from NSShadow object
	///
	/// - Parameter shadow: shadow object
	public init?(shadow: NSShadow?) {
		guard let shadow = shadow else { return nil }
		self.shadow = shadow
	}
	
	/// Return represented NSShadow object
	public var shadowObj: NSShadow {
		return self.shadow
	}
}

public struct StrikeAttribute {
	/// The value of this attribute is a UIColor object. The default value is nil, indicating same as foreground color.
	public let color: UIColor?
	
	/// This value indicates whether the text has a line through it and corresponds to one of the constants described in NSUnderlineStyle.
	/// The default value for this attribute is styleNone.
	public let style: NSUnderlineStyle?
	
	public init(color: UIColor?, style: NSUnderlineStyle?) {
		self.color = color
		self.style = style
	}
}


//MARK: StrokeAttribute

public struct StrokeAttribute {
	
	/// If it is not defined (which is the case by default),
	// it is assumed to be the same as the value of color; otherwise, it describes the outline color.
	public let color: UIColor?
	
	/// This value represents the amount to change the stroke width and is specified as a percentage
	/// of the font point size. Specify 0 (the default) for no additional changes. Specify positive values to change the
	/// stroke width alone. Specify negative values to stroke and fill the text. For example, a typical value for
	/// outlined text would be 3.0.
	public let width: CGFloat?
	
	public init(color: UIColor?, width: CGFloat?) {
		self.color = color
		self.width = width
	}
	
}

//MARK: UnderlineAttribute

public struct UnderlineAttribute {
	/// The value of this attribute is a UIColor object. The default value is nil, indicating same as foreground color.
	public let color: UIColor?
	
	/// This value indicates whether the text is underlined and corresponds to one of the constants described in NSUnderlineStyle.
	/// The default value for this attribute is styleNone.
	public let style: NSUnderlineStyle?
	
	public init(color: UIColor?, style: NSUnderlineStyle?) {
		self.color = color
		self.style = style
	}
	
}

//MARK: FontAttribute

/// FontAttribute define a safe type font
public struct FontAttribute {
	
	/// This define a type safe font name
	public var name: FontName? {
		get {
			guard let fontName = FontName(rawValue: self.font.fontName) else {
				return nil
			}
			return fontName
		}
	}
	
	/// Get the cached UIFont instance
	private(set) var font: UIFont
	
	/// Size of the font
	public var size: Float
	
	/// Create a new FontAttribute with given name and size
	///
	/// - Parameters:
	///   - name: name of the font (may be type safe or custom). You can extend the FontAttribute enum in order to include your own typesafe names
	///   - size: size of the font
	public init(_ name: FontName, size: Float) {
		self.font = UIFont(name: name.rawValue, size: CGFloat(size))!
		self.size = size
	}
	
	/// Create a new FontAttribute name with given font name and size
	/// - return: may return nil if name is not part of font's collection
	public init?(_ name: String, size: Float) {
		guard let font = UIFont(name: name, size: CGFloat(size)) else {
			return nil
		}
		self.font = font
		self.size = size
	}
	
	/// Create a new FontAttribute from given UIFont instance
	/// - return: may return nil if font is not passed or not valid
	public init?(font: UIFont?) {
		guard let font = font else {
			return nil
		}
		self.font = font
		self.size = Float(font.pointSize)
	}
	
	/// System font
	///
	/// - Parameter size: size
	/// - Returns: a new FontAttribute
	public static func system(size: CGFloat) -> FontAttribute {
		return FontAttribute(font: UIFont.systemFont(ofSize: size))!
	}
	
	/// Bold system font
	///
	/// - Parameter size: size
	/// - Returns: a new FontAttribute
	public static func bold(size: CGFloat) -> FontAttribute {
		return FontAttribute(font: UIFont.boldSystemFont(ofSize: size))!
	}
	
	/// Italic system font
	///
	/// - Parameter size: size
	/// - Returns: a new FontAttribute
	public static func italic(size: CGFloat) -> FontAttribute {
		return FontAttribute(font: UIFont.italicSystemFont(ofSize: size))!
	}
	
}
