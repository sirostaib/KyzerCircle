//
//  ViewController.swift
//  KyzerCircle
//
//  Created by Siros Taib on 6/11/24.
//

import UIKit

class MainVC: UIViewController {
    
    var circleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        // Add circle view
        circleView = UIView(frame: CGRect(origin: view.center, size: CGSize(width: 100.0, height: 100.0)))
        circleView.layer.cornerRadius = circleView.frame.width / 2.0
        circleView.center = view.center
        circleView.backgroundColor = .cyan
        view.addSubview(circleView)
        AddGest()
    }
    
    func AddGest() {
        // Add gesture recognizer
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(circleMoved(_:)))
        circleView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func circleMoved(_ recognizer: UIPanGestureRecognizer) {
        let location = recognizer.location(in: view)
        UIView.animate(withDuration: 0.1) {
            self.circleView.center = location
        }
    }
    
}

