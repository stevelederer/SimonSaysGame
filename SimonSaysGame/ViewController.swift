//
//  ViewController.swift
//  SimonSaysGame
//
//  Created by Steve Lederer on 1/7/19.
//  Copyright © 2019 Steve Lederer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let topLeftButton = UIButton()
    let topRightbutton = UIButton()
    let bottomLeftButton = UIButton()
    let bottomRightButton = UIButton()
    let grayView = UIView()
    let displayLabel = UILabel()
    
    let margin: CGFloat = 50
    
    let game = GamePlay()
    var isGameOver = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        game.startNewGame()
        showSequenceOfPresses()
    }
    
    func showSequenceOfPresses() {
        view.isUserInteractionEnabled = false
        
        var count = 1.0
        
        for move in game.correctMoves {
            var colorAsString: String
            switch move {
            case 0:
                colorAsString = "red"
            case 1:
                colorAsString = "yellow"
            case 2:
                colorAsString = "green"
            case 3:
                colorAsString = "blue"
            default:
                colorAsString = "unknown"
            }
            
            show(colorAsString, after: count)
            count += 1.0
            
        }
        
        view.isUserInteractionEnabled = true
    }
    
    func show(_ text: String, after delay: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.displayLabel.text = text
            self.displayLabel.alpha = 1.0
            UIView.animate(withDuration: 1.0, animations: {
                self.displayLabel.alpha = 0.0
            })
        }
    }
    
    func setUpViews() {
        setUpGrayView()
        setUpTopLeftButton()
        setUpTopRightButton()
        setUpBottomLeftButton()
        setUpBottomRightButton()
    }
    
    func setUpGrayView() {
        grayView.backgroundColor = UIColor.gray
        view.addSubview(grayView)
        grayView.translatesAutoresizingMaskIntoConstraints = false
        
        // constraints for grayView
        grayView.heightAnchor.constraint(equalToConstant: margin).isActive = true
        grayView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        grayView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        grayView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        displayLabel.text = ""
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        grayView.addSubview(displayLabel)
        
        displayLabel.centerXAnchor.constraint(equalTo: grayView.centerXAnchor).isActive = true
        displayLabel.centerYAnchor.constraint(equalTo: grayView.centerYAnchor).isActive = true
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        if isGameOver {
            // start a new game
            isGameOver = false
            displayLabel.text = ""
            game.startNewGame()
            showSequenceOfPresses()
        }
        
        let response = game.userSelected(sender.tag)
        
        switch response {
        case .correctAndContinue:
            print("Correct! Now tell the user they were right.")
            show("Correct", after: 0)
        case .correctAndNewRound:
            show("Correct, time for new round!", after: 0)
            showSequenceOfPresses()
            print("Correct! Now tell the user what the next round should be.")
        case .incorrect:
            displayLabel.alpha = 1.0
            displayLabel.text = "You lost. Press any button to start again"
            isGameOver = true
        }
    }
    
    func setUpTopLeftButton() {
        topLeftButton.tag = 0
        topLeftButton.backgroundColor = Constants.colors[topLeftButton.tag]
        topLeftButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        view.addSubview(topLeftButton)
        topLeftButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: topLeftButton,
                           attribute: .left,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .left,
                           multiplier: 1,
                           constant: margin).isActive = true
        
        NSLayoutConstraint(item: topLeftButton,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .top,
                           multiplier: 1,
                           constant: margin).isActive = true
        
        NSLayoutConstraint(item: topLeftButton,
                           attribute: .right,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: -margin/2).isActive = true
        
        NSLayoutConstraint(item: topLeftButton,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerY,
                           multiplier: 1,
                           constant: -margin).isActive = true
    }
    
    func setUpTopRightButton() {
        topRightbutton.tag = 1
        topRightbutton.backgroundColor = Constants.colors[topRightbutton.tag]
        topRightbutton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        view.addSubview(topRightbutton)
        topRightbutton.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = NSLayoutConstraint(item: topRightbutton,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: margin)
        
        let leftConstraint = NSLayoutConstraint(item: topRightbutton,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: topLeftButton,
                                                attribute: .right,
                                                multiplier: 1,
                                                constant: margin)
        
        let rightConstraint = NSLayoutConstraint(item: topRightbutton,
                                                 attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: view,
                                                 attribute: .right,
                                                 multiplier: 1,
                                                 constant: -margin)
        
        let bottomConstraint = NSLayoutConstraint(item: topRightbutton,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: topLeftButton,
                                                  attribute: .bottom,
                                                  multiplier: 1,
                                                  constant: 0)
        
        view.addConstraints([topConstraint, leftConstraint, rightConstraint, bottomConstraint])
        
    }
    
    func setUpBottomLeftButton() {
        bottomLeftButton.tag = 2
        bottomLeftButton.backgroundColor = Constants.colors[bottomLeftButton.tag]
        bottomLeftButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        view.addSubview(bottomLeftButton)
        bottomLeftButton.translatesAutoresizingMaskIntoConstraints = false
        
        bottomLeftButton.topAnchor.constraint(equalTo: topLeftButton.bottomAnchor, constant: margin).isActive = true
        bottomLeftButton.bottomAnchor.constraint(equalTo: grayView.topAnchor, constant: -margin).isActive = true
        bottomLeftButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin).isActive = true
        bottomLeftButton.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -margin/2).isActive = true
    }
    
    func setUpBottomRightButton() {
        bottomRightButton.tag = 3
        bottomRightButton.backgroundColor = Constants.colors[bottomRightButton.tag]
        bottomRightButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        view.addSubview(bottomRightButton)
        bottomRightButton.translatesAutoresizingMaskIntoConstraints = false
        
        bottomRightButton.topAnchor.constraint(equalTo: topLeftButton.bottomAnchor, constant: margin).isActive = true
        bottomRightButton.bottomAnchor.constraint(equalTo: grayView.topAnchor, constant: -margin).isActive = true
        bottomRightButton.leftAnchor.constraint(equalTo: bottomLeftButton.rightAnchor, constant: margin).isActive = true
        bottomRightButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin).isActive = true
    }
}

extension UIButton {
    open override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.lightGray : Constants.colors[self.tag]
        }
    }
}

