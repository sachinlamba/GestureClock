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
        
    }
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        holdRoller()
//        
//    }
    
    func dragRoller(sender: UIPanGestureRecognizer) {
        let point = sender.locationInView(mainClock)
        //rollerImage.center = point
        let slope = (point.y - yCentre)/(point.x - xCentre)

        let yFinal = yCentre + cos(slope)*clockRadius
        let xFinal = xCentre + sin(slope)*clockRadius
            
        rollerImage.center = CGPoint(x: xFinal, y: yFinal)
        
    }
    
    func holdRoller() {
        let path = UIBezierPath()
        
        // path.moveToPoint(CGPoint(x: 180, y: 35))
        
        //        path.addQuadCurveToPoint(CGPoint(x: 180, y: 350), controlPoint: CGPoint(x: 520, y: 185))
        
        path.addArcWithCenter(CGPoint(x: xStart, y: yStart), radius: CGFloat(150), startAngle: CGFloat(-M_PI/2), endAngle: CGFloat(M_PI/2), clockwise: true)
        
        //        let animate = CAKeyframeAnimation(keyPath: "position")
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.CGPath
        
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        
        animation.repeatCount = 0
        animation.duration = 5.0
        
        rollerImage.layer.addAnimation(animation, forKey: "animate position along path")
        
    }
    
    

}

