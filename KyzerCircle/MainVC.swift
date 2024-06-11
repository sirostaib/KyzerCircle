//
//  ViewController.swift
//  KyzerCircle
//
//  Created by Siros Taib on 6/11/24.
//

import UIKit
import ChameleonFramework
import RxSwift
import RxCocoa

class MainVC: UIViewController {
    
    var circleView: UIView!
    fileprivate var circleViewModel: CircleViewModel!
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
  
    func setup() {
        layoutCircle()
        
        subscribeToCircleVM()
        
        addGestRecognizer()
    }
    
    func layoutCircle() {
        // Add circle view
        circleView = UIView(frame: CGRect(origin: view.center, size: CGSize(width: 100.0, height: 100.0)))
        circleView.layer.cornerRadius = circleView.frame.width / 2.0
        circleView.center = view.center
        circleView.backgroundColor = .green
        view.addSubview(circleView)
    }
    
    func subscribeToCircleVM(){
        
        circleViewModel = CircleViewModel()
   
        circleView
            .rx.observe(CGPoint.self, "center")
            .bind(to: circleViewModel.centerVariable)
            .disposed(by: disposeBag)
        
        // Subscribe to backgroundObservable to get new colors from the ViewModel.
        circleViewModel.backgroundColorObservable
            .subscribe(onNext:{ [weak self] backgroundColor in
                if let color = backgroundColor as? UIColor {
                    // Safely use color as UIColor
                    UIView.animate(withDuration: 0.1) {
                        self?.circleView.backgroundColor = color
                        // Try to get complementary color for given background color
                        let viewBackgroundColor = UIColor(complementaryFlatColorOf: color)
                        // If it is different that the color
                        if viewBackgroundColor != color {
                            // Assign it as a background color of the view
                            // We only want different color to be able to see that circle in a view
                            self?.view.backgroundColor = viewBackgroundColor
                        }
                    }
                } else {
                    // Handle unexpected type
                    print("Expected UIColor but got \(type(of: backgroundColor))")
                }
            })
            .disposed(by: disposeBag)
    }
    
    func addGestRecognizer() {
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

