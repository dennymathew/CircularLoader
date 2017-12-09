//
//  ViewController.swift
//  CircularLoader
//
//  Created by Denny Mathew on 09/12/17.
//  Copyright © 2017 Denny Mathew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let shapelayer = CAShapeLayer()
    let progressLabel: UILabel = {
        let label = UILabel()
        label.text = "0%"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createProgressView()
        createProgressLabel()
        
        //Gesture Recognizer
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    fileprivate func createProgressView() {
        let center = view.center
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        //Track Layer
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        trackLayer.lineWidth = 10
        trackLayer.strokeEnd = 1
        trackLayer.lineCap = kCALineCapRound
        trackLayer.fillColor = UIColor.clear.cgColor
        
        view.layer.addSublayer(trackLayer)
        
        //Progress Layer
        shapelayer.path = circularPath.cgPath
        shapelayer.strokeColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        shapelayer.lineWidth = 10
        shapelayer.strokeEnd = 0
        shapelayer.lineCap = kCALineCapRound
        shapelayer.fillColor = UIColor.clear.cgColor
        
        view.layer.addSublayer(shapelayer)
    }
    
    func createProgressLabel() {
        view.addSubview(progressLabel)
        NSLayoutConstraint.activate([
            progressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    @objc private func handleTap() {
        print("Animate It!")
        
        let viewAnimation = CABasicAnimation(keyPath: "strokeEnd")
        viewAnimation.toValue = 1
        viewAnimation.duration = 2
        viewAnimation.fillMode = kCAFillModeForwards
        viewAnimation.isRemovedOnCompletion = false
        
        shapelayer.add(viewAnimation, forKey: "urSoBasic")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

