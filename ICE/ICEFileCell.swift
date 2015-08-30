//
//  ICEFileCell.swift
//  ICE
//
//  Created by Andrea Cabral on 18.11.14.
//  Copyright (c) 2014 Andrea Cabral. All rights reserved.
//

import UIKit

class ICEFileCell: UICollectionViewCell {
    
    //let imageView : UIImageView = UIImageView()
    var label = UILabel()

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.label.text = "No File"
        self.selectedBackgroundView = ICEFileCustomCellBackground(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.label.text = "file"
        self.label.textColor = UIColor.blackColor()
        self.label.frame = CGRect(x: 0.0, y: (self.frame.height/2) - 7.5, width: 50.0, height: 15.0)
        self.label.textAlignment = NSTextAlignment.Center
        self.label.textRectForBounds(self.frame, limitedToNumberOfLines: 0)
        self.addSubview(self.label)
    }
}
