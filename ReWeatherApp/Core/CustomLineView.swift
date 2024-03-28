//
//  CustomLineView.swift
//  ReWeatherApp
//
//  Created by Alikhan Tursunbekov on 28/3/24.
//

import UIKit

class CustomSmoothLineView: UIView {
    let points: [CGPoint]

    init(points: [CGPoint]) {
        self.points = points
        super.init(frame: .zero)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext(), points.count > 1 else { return }

        context.beginPath()
        context.move(to: points[0])

        var p1 = points[0]
        for i in 1..<points.count {
            let p2 = points[i]
            let midPoint = midpoint(p1: p1, p2: p2)
            
            context.addQuadCurve(to: midPoint, control: controlPoint(p1: midPoint, p2: p1))
            context.addQuadCurve(to: p2, control: controlPoint(p1: midPoint, p2: p2))
            
            p1 = p2
        }

        context.setStrokeColor(UIColor(hex: "#FFC355").cgColor)
        context.setLineWidth(2)
        context.strokePath()
    }
    
    private func midpoint(p1: CGPoint, p2: CGPoint) -> CGPoint {
        return CGPoint(x: (p1.x + p2.x) / 2, y: (p1.y + p2.y) / 2)
    }

    private func controlPoint(p1: CGPoint, p2: CGPoint) -> CGPoint {
        var controlPoint = midpoint(p1: p1, p2: p2)
        let diffY = abs(p2.y - controlPoint.y)
        
        if p1.y < p2.y {
            controlPoint.y += diffY
        } else if p1.y > p2.y {
            controlPoint.y -= diffY
        }
        return controlPoint
    }
}
