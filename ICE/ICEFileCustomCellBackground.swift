//
//  ICEFileCustomCellBackground.swift
//  ICE
//
//  Created by Andrea Cabral on 18.11.14.
//  Copyright (c) 2014 Andrea Cabral. All rights reserved.
//

import UIKit
import CoreGraphics

class ICEFileCustomCellBackground: UIView {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let aRef: CGContextRef = UIGraphicsGetCurrentContext()
        CGContextSaveGState(aRef)
        let aBezierPath: UIBezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 0.0)
        aBezierPath.lineWidth = 1.0
        UIColor.whiteColor().setStroke()
        
        let fillColor : UIColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        fillColor.setFill()
        
        aBezierPath.stroke()
        aBezierPath.fill()
        CGContextRestoreGState(aRef)
    }
}
