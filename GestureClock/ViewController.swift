//
//  ViewController.swift
//  GestureClock
//
//  Created by Sachin Lamba on 22/07/16.
//  Copyright © 2016 LambaG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var mainClock = UIImageView()
    var rollerImage = UIImageView()
    var panRoller = UIPanGestureRecognizer()
    
    let xCentre: CGFloat = 197
    let yCentre: CGFloat = 197
    let xStart: CGFloat = 180
    let yStart: CGFloat = 35
    let clockRadius:CGFloat = 150
    
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let clockImage = UIImage(named: "circle")
        mainClock.image = clockImage
        mainClock.frame = CGRect(x: 0, y: 200, width: 400, height: 400)
        view.addSubview(mainClock)
        let innerClockCircle = UIImageView(frame: CGRect(x: 50, y: 50, width: 300, height: 300))
        innerClockCircle.image = clockImage
        mainClock.addSubview(innerClockCircle)
        
        view.backgroundColor = UIColor.yellowColor()
        
        let centerImage = UIImageView(frame: CGRect(x: 197, y: 197, width: 10, height: 10))
        centerImage.image = clockImage
        mainClock.addSubview(centerImage)
        
        rollerImage = UIImageView(frame: CGRect(x: xStart, y: yStart, width: 40, height: 40))
        rollerImage.image = clockImage
        mainClock.addSubview(rollerImage)
        
        panRoller = UIPanGestureRecognizer(target: self, action: #selector(dragRoller))
        view.addGestureRecognizer(panRoller)
        
        rollerImage.userInteractionEnabled = true
        
        button.frame = CGRect(x: 160, y: 60, width: 80, height: 80)
        button.backgroundColor = UIColor.redColor()
        //button.titleLabel = "Start"
        //button.currentTitle = "Start"
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(holdRoller), forControlEvents: .TouchUpInside)
        
    }
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        holdRoller()
//        
//    }
    
    func dragRoller(sender: UIPanGestureRecognizer) {
        let point = sender.locationInView(mainClock)
        //rollerImage.center = point
        //let slope = (point.y - yCentre)/(point.x - xCentre)
        var yFinal = yCentre
        var xFinal = xCentre
        
        //let x = atan(slope)
        //let x = atan2(slope, 1)
        let x = atan2f(Float(point.y - yCentre), Float(point.x - xCentre))
        
//        if point.x > xCentre && point.y > yCentre {             //1
//            yFinal = yCentre + sin(CGFloat(x))*clockRadius
//            xFinal = xCentre + cos(CGFloat(x))*clockRadius
//            
//        } else if point.x > xCentre && point.y < yCentre {      //4
//            yFinal = yCentre + sin(CGFloat(x))*clockRadius
//            xFinal = xCentre - cos(CGFloat(x))*clockRadius
//
//        } else if point.x < xCentre && point.y > yCentre {      //2
//            yFinal = yCentre - sin(CGFloat(x))*clockRadius
//            xFinal = xCentre + cos(CGFloat(x))*clockRadius
//
//        } else if point.x < xCentre && point.y < yCentre {      //3
//            yFinal = yCentre - sin(CGFloat(x))*clockRadius
//            xFinal = xCentre - cos(CGFloat(x))*clockRadius
//
//        }
        yFinal = yCentre + sin(CGFloat(x))*clockRadius
        xFinal = xCentre + cos(CGFloat(x))*clockRadius
        
        UIView.animateWithDuration(2, animations: {
            self.rollerImage.center = CGPoint(x: xFinal, y: yFinal)
        })
    }
    
    func holdRoller() {
        let path = UIBezierPath()
        
         //path.moveToPoint(CGPoint(x: rollerImage.frame.origin.x, y: rollerImage.frame.origin.y))
        
        //        path.addQuadCurveToPoint(CGPoint(x: 180, y: 350), controlPoint: CGPoint(x: 520, y: 185))
        
        let theta = atan2f(Float(rollerImage.frame.origin.y - yCentre), Float(rollerImage.frame.origin.x - xCentre))
        
        path.addArcWithCenter(CGPoint(x: xCentre, y: yCentre), radius: CGFloat(150), startAngle: CGFloat(theta), endAngle: CGFloat(-M_PI/2), clockwise: false)
        
        //path.addQuadCurveToPoint(CGPoint(x: xStart, y: yStart), controlPoint: CGPoint(x: xStart+1, y: yStart+1))
        
        //        let animate = CAKeyframeAnimation(keyPath: "position")
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.CGPath
        
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        var duration = 10
        if theta > 0 && theta < 3.14/2 {
            duration = 20
        } else if theta > 3.14/2 && theta < 3.14{
            duration = 35
        } else if theta < 0 && theta > -3.14/2 {
            duration = 5
        } else if theta < -3.14/2 && theta > -3.14 {
            duration = 45
        }
        
        animation.repeatCount = 0
        animation.duration = Double(duration)
        
        rollerImage.layer.addAnimation(animation, forKey: "animate position along path")
        
    }
    
    

}

