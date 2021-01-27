//
//  TransitionDriver.swift
//  PanelDrawer
//
//  Created by Александр on 28.01.2021.
//

import UIKit

enum TransitionDirection {
    case present
    case dismiss
}

class TransitionDriver: UIPercentDrivenInteractiveTransition {
    
    var direction: TransitionDirection = .present

    
    private weak var presentedController: UIViewController?
    private weak var presentingController: UIViewController?
    private var panRecognizer: UIPanGestureRecognizer?
    
    weak var scrollView: UIScrollView?
    
    // MARK: Overridden
    
    override var wantsInteractiveStart: Bool {
        get {
            let gestureIsActive = panRecognizer?.state == .began
            return gestureIsActive
        }

        set { }
    }
    
    // MARK: Internal
    
    func link(to presented: UIViewController,
                presenting: UIViewController) {
        presentedController = presented
        presentingController = presenting
        
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handle(recognizer:)))
        presentedController?.view.addGestureRecognizer(panRecognizer!)
        
        panRecognizer?.delegate = self
        
        if let scrollableVC = presentedController as? ScrollablePanelDrawer {
            scrollView = scrollableVC.scrollView
        }
    }
    
    
    // MARK: Actions
    
    @objc private func handle(recognizer r: UIPanGestureRecognizer) {
        switch direction {
        case .present:
            handlePresentation(recognizer: r)
        case .dismiss:
            handleDismiss(recognizer: r)
        }
    }
    

    
}

extension TransitionDriver {
    
    var maxTranslation: CGFloat {
        presentedController?.view.frame.height ?? 0
    }
    
    /// `pause()` before call `isRunning`
    private var isRunning: Bool {
        return percentComplete != 0
    }
    
    @objc private func handlePresentation(recognizer r: UIPanGestureRecognizer) {
        switch r.state {
        case .began:
            pause()
            
            if !isRunning {
                presentingController?.present(presentedController!, animated: true)
            }
        case .changed:
            let increment = -r.incrementToBottom(maxTranslation: maxTranslation)
            update(percentComplete + increment)
            
        case .ended, .cancelled:
            if r.isProjectedToDownHalf(maxTranslation: maxTranslation) {
                cancel()
            } else {
                scrollView?.isScrollEnabled = true
                finish()
            }
            
        case .failed:
            cancel()
            
        default:
            break
        }
    }
    
    private func handleDismiss(recognizer r: UIPanGestureRecognizer) {
        switch r.state {
        case .began:
            pause() // Pause allows to detect isRunning
            
            if !isRunning {
                presentedController?.dismiss(animated: true) // Start the new one
            }
        
        case .changed:
            update(percentComplete + r.incrementToBottom(maxTranslation: maxTranslation))
            
        case .ended, .cancelled:
            if r.isProjectedToDownHalf(maxTranslation: maxTranslation) {
                finish()
            } else {
                scrollView?.isScrollEnabled = true
                cancel()
            }

        case .failed:
            cancel()
            
        default:
            break
        }
    }
    
}

extension TransitionDriver: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {

        guard let gesture = gestureRecognizer as? UIPanGestureRecognizer,
              let scrollView = scrollView else { return false }

        let direction = gesture.velocity(in: presentingController!.view).y

        let scrollContentOffset = scrollView.contentOffset

        if (scrollContentOffset.y <= 0 && direction >= 0) {
            scrollView.isScrollEnabled = false
        } else {
            scrollView.isScrollEnabled = true
        }

        return false
    }
    
    
}

private extension UIPanGestureRecognizer {
    
    func incrementToBottom(maxTranslation: CGFloat) -> CGFloat {
        let translation = self.translation(in: view).y
        setTranslation(.zero, in: nil)

        let percentIncrement = translation / maxTranslation
        return percentIncrement
    }
    
    
    func isProjectedToDownHalf(maxTranslation: CGFloat) -> Bool {
        let endLocation = projectedLocation(decelerationRate: .fast)
        let isPresentationCompleted = endLocation.y > maxTranslation / 2

        return isPresentationCompleted
    }
 
}
