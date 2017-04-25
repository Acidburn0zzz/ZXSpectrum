//
//  JoystickStyleKit.swift
//  ZX Spectrum
//
//  Created by Tomaz Kragelj on 21.04.17.
//  Copyright © 2017 Gentle Bytes. All rights reserved.
//
//  Generated by PaintCode
//  http://www.paintcodeapp.com
//



import UIKit

public class JoystickStyleKit : NSObject {

    //// Cache

    private struct Cache {
        static let joystickBackgroundColor: UIColor = UIColor(red: 0.366, green: 0.366, blue: 0.366, alpha: 1.000)
        static let joystickLightBackgroundColor: UIColor = JoystickStyleKit.joystickBackgroundColor.highlight(withLevel: 0.1)
    }

    //// Colors

    public dynamic class var joystickBackgroundColor: UIColor { return Cache.joystickBackgroundColor }
    public dynamic class var joystickLightBackgroundColor: UIColor { return Cache.joystickLightBackgroundColor }

    //// Drawing Methods

    public dynamic class func drawJoystickBackground(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 250, height: 250), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 250, height: 250), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 250, y: resizedFrame.height / 250)


        //// Color Declarations
        let joystickDarkBackgroundColor = JoystickStyleKit.joystickBackgroundColor.shadow(withLevel: 0.3)

        //// Gradient Declarations
        let joystickBackgroundGradient = CGGradient(colorsSpace: nil, colors: [JoystickStyleKit.joystickBackgroundColor.cgColor, JoystickStyleKit.joystickBackgroundColor.blended(withFraction: 0.5, of: JoystickStyleKit.joystickLightBackgroundColor).cgColor, JoystickStyleKit.joystickLightBackgroundColor.cgColor] as CFArray, locations: [0, 0.45, 1])!

        //// Background Drawing
        let backgroundPath = UIBezierPath(ovalIn: CGRect(x: 1, y: 1, width: 248, height: 248))
        context.saveGState()
        backgroundPath.addClip()
        context.drawLinearGradient(joystickBackgroundGradient, start: CGPoint(x: 212.68, y: 212.68), end: CGPoint(x: 37.32, y: 37.32), options: [])
        context.restoreGState()
        joystickDarkBackgroundColor.setStroke()
        backgroundPath.lineWidth = 1
        backgroundPath.stroke()
        
        context.restoreGState()

    }

    public dynamic class func drawJoystickThumb(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 160, height: 160), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 160, height: 160), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 160, y: resizedFrame.height / 160)


        //// Color Declarations
        let joystickDarkBackgroundColor = JoystickStyleKit.joystickBackgroundColor.shadow(withLevel: 0.3)
        let joystickFrameColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1.000)

        //// Gradient Declarations
        let joystickThumbGradient = CGGradient(colorsSpace: nil, colors: [joystickDarkBackgroundColor.cgColor, JoystickStyleKit.joystickBackgroundColor.cgColor] as CFArray, locations: [0, 1])!

        //// Oval 2 Drawing
        let oval2Path = UIBezierPath(ovalIn: CGRect(x: 1, y: 1, width: 158, height: 158))
        context.saveGState()
        oval2Path.addClip()
        context.drawLinearGradient(joystickThumbGradient, start: CGPoint(x: 24.14, y: 24.14), end: CGPoint(x: 135.86, y: 135.86), options: [])
        context.restoreGState()
        joystickFrameColor.setStroke()
        oval2Path.lineWidth = 1
        oval2Path.stroke()
        
        context.restoreGState()

    }




    @objc(JoystickStyleKitResizingBehavior)
    public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.

        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }

            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)

            switch self {
                case .aspectFit:
                    scales.width = min(scales.width, scales.height)
                    scales.height = scales.width
                case .aspectFill:
                    scales.width = max(scales.width, scales.height)
                    scales.height = scales.width
                case .stretch:
                    break
                case .center:
                    scales.width = 1
                    scales.height = 1
            }

            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}



private extension UIColor {
    func withHue(_ newHue: CGFloat) -> UIColor {
        var saturation: CGFloat = 1, brightness: CGFloat = 1, alpha: CGFloat = 1
        self.getHue(nil, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: newHue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    func withSaturation(_ newSaturation: CGFloat) -> UIColor {
        var hue: CGFloat = 1, brightness: CGFloat = 1, alpha: CGFloat = 1
        self.getHue(&hue, saturation: nil, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: hue, saturation: newSaturation, brightness: brightness, alpha: alpha)
    }
    func withBrightness(_ newBrightness: CGFloat) -> UIColor {
        var hue: CGFloat = 1, saturation: CGFloat = 1, alpha: CGFloat = 1
        self.getHue(&hue, saturation: &saturation, brightness: nil, alpha: &alpha)
        return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
    }
    func withAlpha(_ newAlpha: CGFloat) -> UIColor {
        var hue: CGFloat = 1, saturation: CGFloat = 1, brightness: CGFloat = 1
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil)
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: newAlpha)
    }
    func highlight(withLevel highlight: CGFloat) -> UIColor {
        var red: CGFloat = 1, green: CGFloat = 1, blue: CGFloat = 1, alpha: CGFloat = 1
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: red * (1-highlight) + highlight, green: green * (1-highlight) + highlight, blue: blue * (1-highlight) + highlight, alpha: alpha * (1-highlight) + highlight)
    }
    func shadow(withLevel shadow: CGFloat) -> UIColor {
        var red: CGFloat = 1, green: CGFloat = 1, blue: CGFloat = 1, alpha: CGFloat = 1
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: red * (1-shadow), green: green * (1-shadow), blue: blue * (1-shadow), alpha: alpha * (1-shadow) + shadow)
    }
    func blended(withFraction fraction: CGFloat, of color: UIColor) -> UIColor {
        var r1: CGFloat = 1, g1: CGFloat = 1, b1: CGFloat = 1, a1: CGFloat = 1
        var r2: CGFloat = 1, g2: CGFloat = 1, b2: CGFloat = 1, a2: CGFloat = 1

        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        return UIColor(red: r1 * (1 - fraction) + r2 * fraction,
            green: g1 * (1 - fraction) + g2 * fraction,
            blue: b1 * (1 - fraction) + b2 * fraction,
            alpha: a1 * (1 - fraction) + a2 * fraction);
    }
}
