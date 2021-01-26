//
//  PresentAnimation.swift
//  PanelDrawer
//
//  Created by Александр on 27.01.2021.
//

import UIKit

class PresentAnimation: NSObject {
    let duration: TimeInterval = 1.0

    private func animator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // transitionContext.view содержит всю нужную информацию, извлекаем её
        let to = transitionContext.view(forKey: .to)!
        let finalFrame = transitionContext.finalFrame(for: transitionContext.viewController(forKey: .to)!) // Тот самый фрейм, который мы задали в PresentationController
        // Смещаем контроллер за границу экрана
        to.frame = finalFrame.offsetBy(dx: 0, dy: finalFrame.height)
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeOut) {
            to.frame = finalFrame // Возвращаем на место, так он выезжает снизу
        }

        animator.addCompletion { (position) in
        // Завершаем переход, если он не был отменён
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        return animator
    }
}

extension PresentAnimation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = self.animator(using: transitionContext)
        animator.startAnimation()
    }

    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        return self.animator(using: transitionContext)
    }
}
