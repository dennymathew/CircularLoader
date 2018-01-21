//
//  ViewController.swift
//  CircularLoader
//
//  Created by Denny Mathew on 09/12/17.
//  Copyright © 2017 Denny Mathew. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let progressPercentage = CGFloat(100 * totalBytesWritten/totalBytesExpectedToWrite)
        DispatchQueue.main.async {
            self.progressLabel.text = "\(Int(progressPercentage))" + "%"
            self.shapelayer.strokeEnd = progressPercentage/100
            print(progressPercentage)
        }
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Finished Downloading File!")
    }
    
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
    
    let urlString = "http://mirrors.standaloneinstaller.com/video-sample/lion-sample.m4v"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createProgressView()
        createProgressLabel()
        
        //Gesture Recognizer
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    fileprivate func createProgressView() {
//        let center = view.center
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        //Track Layer
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        trackLayer.lineWidth = 10
        trackLayer.strokeEnd = 1
        trackLayer.lineCap = kCALineCapRound
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.position = view.center
        
        view.layer.addSublayer(trackLayer)
        
        //Progress Layer
        shapelayer.path = circularPath.cgPath
        shapelayer.strokeColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        shapelayer.lineWidth = 10
        shapelayer.strokeEnd = 0
        shapelayer.lineCap = kCALineCapRound
        shapelayer.fillColor = UIColor.clear.cgColor
        shapelayer.position = view.center
        shapelayer.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
        
        view.layer.addSublayer(shapelayer)
    }
    
    func createProgressLabel() {
        view.addSubview(progressLabel)
        NSLayoutConstraint.activate([
            progressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    private func beginDownloadingFile() {
        print("Downloading File...")
        shapelayer.strokeEnd = 0
        
        //Download File
        let configuration = URLSessionConfiguration.default
        let operationQueue = OperationQueue()
        let urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
        
        guard let url = URL(string: urlString) else {
            return
        }
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
    }
    
    fileprivate func animateCircle(_ toValue: Double) {
        let viewAnimation = CABasicAnimation(keyPath: "strokeEnd")
        viewAnimation.toValue = 1
        viewAnimation.duration = toValue
        viewAnimation.fillMode = kCAFillModeForwards
        viewAnimation.isRemovedOnCompletion = false
        
        shapelayer.add(viewAnimation, forKey: "urSoBasic")
    }
    
    @objc private func handleTap() {
        print("Animate It!")
        beginDownloadingFile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

