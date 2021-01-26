//
//  PanelTransition.swift
//  PanelDrawer
//
//  Created by Александр on 27.01.2021.
//

import UIKit

class PanelTransition: NSObject, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented,
                                      presenting: presenting ?? source)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        PresentAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        DismissAnimation()
    }
}
