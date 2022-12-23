//
//  UisegmentedView.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 18/12/22.
//

import Foundation
import UIKit
import SnapKit

class UisegmentedView: UISegmentedControl {
    
}

extension UIImage {
    class func getSegmentRect(color: CGColor, andSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        context?.fill(rectangle)
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }
}

extension UISegmentedControl{
    func removeBorder(){
        let background = UIImage.getSegmentRect(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor, andSize: self.bounds.size)
        self.setBackgroundImage(background, for: .normal, barMetrics: .default)
        self.setBackgroundImage(background, for: .selected, barMetrics: .default)
        self.setBackgroundImage(background, for: .highlighted, barMetrics: .default)
        let devideLine = UIImage.getSegmentRect(color: UIColor.black.cgColor, andSize: CGSize(width: 1.0, height: 5))
        self.setDividerImage(devideLine, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.gray], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 61/255, green: 192/255, blue: 200/255, alpha: 1.0)], for: .selected)
    }
    
    func higlightSelectedSegment(){
        removeBorder()
        let lineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let lineHeight:CGFloat = 7.0
        let lineXPositioin = CGFloat(selectedSegmentIndex * Int(lineWidth))
        let lineYPosition = self.bounds.size.height - 6.0
        let underLineFrame = CGRect(x: lineXPositioin, y: lineYPosition, width: lineWidth, height: lineHeight)
        let underLine = UIView(frame: underLineFrame)
        underLine.backgroundColor = UIColor(red: 61/255, green: 192/255, blue: 200/255, alpha: 1.0)
        underLine.tag = 1
        self.addSubview(underLine)
    }
    
    func underLinePosition(){
        guard let underLine = self.viewWithTag(1) else {return}
        let xPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            underLine.frame.origin.x = xPosition
        })
    }
    
}
