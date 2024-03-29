//
//  CustomLineView.swift
//  ReWeatherApp
//
//  Created by Alikhan Tursunbekov on 28/3/24.
//

import UIKit

class SmoothChartView: UIView {
    var points: [(x: CGFloat, y: CGFloat)]
    var temperatures: [String]
    var image: UIImage?
    
    init(points: [(x: CGFloat, y: CGFloat)], temperatures: [String], image: UIImage? = nil) {
        self.points = points
        self.temperatures = temperatures
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard !points.isEmpty else { return }
        
        let scaledPoints = points.map { CGPoint(x: $0.x, y: rect.height - $0.y) }
        guard let context = UIGraphicsGetCurrentContext(), scaledPoints.count > 1 else { return }
        
        context.beginPath()
        context.move(to: scaledPoints.first!)
        
        var p1 = scaledPoints[0]
        for i in 1..<scaledPoints.count {
            let p2 = scaledPoints[i]
            let controlPoints = controlPointsForPoints(p1: p1, p2: p2)
            context.addCurve(to: p2, control1: controlPoints.0, control2: controlPoints.1)
            p1 = p2
        }
        
        UIColor.init(hex: "#FFC355").setStroke()
        context.setLineWidth(2)
        context.strokePath()
        drawPointsLabelsAndImage(on: scaledPoints, in: rect)
    }
    
    private func controlPointsForPoints(p1: CGPoint, p2: CGPoint) -> (CGPoint, CGPoint) {
        let controlPoint1 = CGPoint(x: (p1.x + p2.x) / 2, y: p1.y)
        let controlPoint2 = CGPoint(x: (p1.x + p2.x) / 2, y: p2.y)
        return (controlPoint1, controlPoint2)
    }
    
    private func drawPointsLabelsAndImage(on points: [CGPoint], in rect: CGRect) {
        for (index, point) in points.enumerated() {
            if index == 1 {
                let dotPath = UIBezierPath(arcCenter: point, radius: 5, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
                UIColor.white.setFill()
                dotPath.fill()
            }

            let label = UILabel(frame: CGRect(x: point.x - 15, y: point.y - 30, width: 35, height: 25))
            label.text = temperatures[index]
            label.font = .inter(size: 14, weight: .medium)
            label.textColor = .white
            label.textAlignment = .center
            addSubview(label)
        }

        if let image = image {
            image.draw(at: CGPoint(x: rect.width / 2 - image.size.width / 2, y: rect.height - image.size.height - 10))
        }
    }
}

extension SmoothChartView {
    func updateChart(withPoints points: [(x: CGFloat, y: CGFloat)], temperatures: [String], image: UIImage? = nil) {
        self.points = points
        self.temperatures = temperatures
        self.image = image
        setNeedsDisplay()
    }
}

