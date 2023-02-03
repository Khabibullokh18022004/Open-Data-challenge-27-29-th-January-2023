//
//  File.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 27/01/23.
//

import UIKit


class QRScannerCenterView: UIView {
    
    var change: CGFloat = 20

    var color = UIColor.orange {
        didSet {
            setNeedsDisplay()
        }
    }
    var radius: CGFloat = 25 {
        didSet {
            setNeedsDisplay()
        }
    }
    var thickness: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    var length: CGFloat = 25 {
        didSet {
            setNeedsDisplay()
        }
    }
   
    override func draw(_ rect: CGRect) {
        color.set()
        
        let t2 = thickness / 2
        let path = UIBezierPath()
        path.lineCapStyle = .round
        path.move(to: CGPoint(x: t2, y: length + radius + t2 + change))
        path.addLine(to: CGPoint(x: t2, y: radius + t2))
        path.addArc(withCenter: CGPoint(x: radius + t2, y: radius + t2), radius: radius, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 3 / 2, clockwise: true)
        path.addLine(to: CGPoint(x: length + radius + t2 + change, y: t2))
        
        path.move(to: CGPoint(x: frame.width - t2, y: length + radius + t2 + change))
        path.addLine(to: CGPoint(x: frame.width - t2, y: radius + t2))
        path.addArc(withCenter: CGPoint(x: frame.width - radius - t2, y: radius + t2), radius: radius, startAngle: 0, endAngle: CGFloat.pi * 3 / 2, clockwise: false)
        path.addLine(to: CGPoint(x: frame.width - length - radius - t2 - change, y: t2))
        
        path.move(to: CGPoint(x: t2, y: frame.height - length - radius - t2 - change))
        path.addLine(to: CGPoint(x: t2, y: frame.height - radius - t2))
        path.addArc(withCenter: CGPoint(x: radius + t2, y: frame.height - radius - t2), radius: radius, startAngle: CGFloat.pi, endAngle: CGFloat.pi / 2, clockwise: false)
        path.addLine(to: CGPoint(x: length + radius + t2 + change, y: frame.height - t2))
        
        path.move(to: CGPoint(x: frame.width - t2, y: frame.height - length - radius - t2 - change))
        path.addLine(to: CGPoint(x: frame.width - t2, y: frame.height - radius - t2))
        path.addArc(withCenter: CGPoint(x: frame.width - radius - t2, y: frame.height - radius - t2), radius: radius, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: true)
        path.addLine(to: CGPoint(x: frame.width - length - radius - t2 - change, y: frame.height - t2))
        
        path.lineWidth = thickness
        path.stroke()
    }

}
