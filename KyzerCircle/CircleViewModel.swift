//
//  CircleViewModel.swift
//  KyzerCircle
//
//  Created by Siros Taib on 6/11/24.
//


import UIKit
import RxSwift
import RxCocoa
import ChameleonFramework
 
class CircleViewModel {
    
    var centerVariable = BehaviorRelay<CGPoint?>(value: .zero) // Create one variable that will be changed and observed
    var backgroundColorObservable: Observable<Any>! // Create observable that will change backgroundColor based on center
    
    init() {
        setup()
    }
 
    func setup() {
        // When we get new center, emit new UIColor
        backgroundColorObservable = centerVariable.asObservable()
            .map { center in
                guard let center = center else { return UIColor.flatten(.black)() }
                
                let red: CGFloat = (center.x + center.y).truncatingRemainder(dividingBy: 255.0) / 255.0 // We just manipulate red, but you can do w/e
                let green: CGFloat = 0.0
                let blue: CGFloat = 0.0
                
                return UIColor.flatten(UIColor(red: red, green: green, blue: blue, alpha: 1.0))()
            }
    }
}
