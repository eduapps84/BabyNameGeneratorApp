//
//  LayoutHelper.swift
//  BabyNameGeneratorApp
//
//  Created by Eduardo Maia on 19/01/23.
//

import Foundation
import UIKit

struct LayoutHelper {
    
    static func showLoading(view: UIView) {
        let activityIndicatorBackground = UIView()
        activityIndicatorBackground.backgroundColor = UIColor.black
        activityIndicatorBackground.alpha = 0.3
        activityIndicatorBackground.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        activityIndicatorBackground.tag = 500
        view.addSubview(activityIndicatorBackground)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor.white
        activityIndicator.center = activityIndicatorBackground.center
        activityIndicator.startAnimating()
        
        activityIndicatorBackground.addSubview(activityIndicator)
    }
    
    static func hideLoading(view: UIView) {
        for subview in view.subviews where subview.tag == 500 {
            subview.removeFromSuperview()
        }
    }
}
