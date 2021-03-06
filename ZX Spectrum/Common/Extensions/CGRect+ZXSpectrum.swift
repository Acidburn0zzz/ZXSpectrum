//
//  Created by Tomaz Kragelj on 21.04.17.
//  Copyright © 2017 Gentle Bytes. All rights reserved.
//

import UIKit

extension CGRect {

	/**
	Returns scaled rectangle to fit within the given target.
	
	Note if you intend to reuse the same scaling for many operations, you might want to use `scaler(from:to:)` instead.
	
	@param source Source rectangle defining the area this instance is measured against.
	@param target Target rectangle within which this instance needs to be scaled.
	@return Scaled rectangle.
	*/
	func scaled(from source: CGRect, to target: CGRect, mode: Scaler.Mode = .fit) -> CGRect {
		return Scaler(from: source, to: target, mode: mode).scaled(rect: self)
	}
	
	/**
	Returns scaler that knows how to scale rects to fit within the given target.
	
	This is optimized `scaled(from:to:)` variant; it performs initial calculations only once and then applies scale to any given rect. It's advised to be used in loops and other places where a lot of scaling within the same source and target rects are needed.
	
	@param source Source rectangle defining the area this instance is measured against.
	@param target Target rectangle within which this instance needs to be scaled.
	@return Scaler for scaling the rectangles.
	*/
	static func scaler(from source: CGRect, to target: CGRect, mode: Scaler.Mode = .fit) -> Scaler {
		return Scaler(from: source, to: target, mode: mode)
	}
	
	class Scaler {
		
		private let scale: CGPoint
		private let offset: CGPoint
		private let mode: Mode
		
		fileprivate init(from source: CGRect, to target: CGRect, mode scaleMode: Mode) {
			let scales = CGSize(
				width: abs(target.width / source.width),
				height: abs(target.height / source.height))
			
			mode = scaleMode
			
			scale = CGPoint(
				x: mode == .fit ? min(scales.width, scales.height) : scales.width,
				y: mode == .fit ? min(scales.width, scales.height) : scales.height)
			
			offset = CGPoint(
				x: target.minX + (target.width - source.width * scale.x) / 2,
				y: target.minY + (target.height - source.height * scale.y) / 2)
		}
		
		func scaled(rect: CGRect) -> CGRect {
			let scaledWidth = rect.width * scale.x
			let scaledHeight = rect.height * scale.y
			
			return CGRect(
				x: offset.x + rect.minX * scale.x,
				y: offset.y + rect.minY * scale.y,
				width: scaledWidth,
				height: scaledHeight)
		}
		
		enum Mode: Int {
			case fit
			case fill
			
			static func mode(fill: Bool) -> Mode {
				return fill ? .fill : .fit
			}
			
			static var `default`: Mode {
				return UIDevice.iPhone ? .fill : .fit
			}
		}
	}
}

extension CGRect: Hashable {
	
	public var hashValue: Int {
		return NSStringFromCGRect(self).hashValue
	}
}
