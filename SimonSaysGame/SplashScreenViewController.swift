//
//  SplashScreenViewController.swift
//  SimonSaysGame
//
//  Created by Steve Lederer on 1/8/19.
//  Copyright © 2019 Steve Lederer. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var blueView: UIView!
    
    @IBOutlet weak var redViewLeftConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton.layer.cornerRadius = playButton.bounds.height/2
        playButton.layer.borderColor = UIColor.lightGray.cgColor
        playButton.layer.borderWidth = 10
        playButton.layer.shadowColor = UIColor.purple.cgColor
        playButton.layer.shadowRadius = 10
        playButton.layer.shadowOpacity = 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateRedView()
        animateGreenView()
        animateYellowView()
        animateBlueView()
    }
    
    func animateRedView() {
        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat], animations: {
            self.redViewLeftConstraint.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func animateGreenView() {
        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .curveLinear], animations: {
            self.greenView.center = CGPoint(x: self.greenView.center.x + self.view.bounds.width, y: self.greenView.center.y)
        }, completion: nil)
    }
    
    func animateYellowView() {
        UIView.animate(withDuration: 2.0, delay: 0, options: [.curveLinear, .repeat], animations: {
            self.yellowView.center = CGPoint(x: self.yellowView.center.x - self.view.bounds.width, y: self.yellowView.center.y)
            self.yellowView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }, completion: nil)
    }
    
    func animateBlueView() {
        UIView.animateKeyframes(withDuration: 2.0, delay: 0, options: [.autoreverse, .repeat], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self.blueView.transform = CGAffineTransform(scaleX: 2, y: 2)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.blueView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            })
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25, animations: {
                self.blueView.center = CGPoint(x: self.blueView.center.x - (0.25 * self.view.bounds.width), y: self.blueView.center.y + 50)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
                self.blueView.center = CGPoint(x: self.blueView.center.x - (0.25 * self.view.bounds.width), y: self.blueView.center.y - 100)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25, animations: {
                self.blueView.center = CGPoint(x: self.blueView.center.x - (0.25 * self.view.bounds.width), y: self.blueView.center.y + 100)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25, animations: {
                self.blueView.center = CGPoint(x: self.blueView.center.x - (0.25 * self.view.bounds.width), y: self.blueView.center.y - 50)
            })
        }, completion: nil)
    }

   

}
