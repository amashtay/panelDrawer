//
//  ViewController.swift
//  PanelDrawer
//
//  Created by Александр Тонхоноев on 19.01.2021.
//

import UIKit

enum PanelDrawerState {
    case full
    case half
    case small
}

protocol ScrollablePanelDrawer: AnyObject {
    var scrollView: UIScrollView? { get }
}

class PanelDrawerController: UIViewController {

    var panelDrawerController: UIViewController!
    var mainController: UIViewController?
    weak var panelScrollView: UIScrollView?

    @IBOutlet weak var mainView: UIView!

    @IBOutlet weak var panelHandlerView: UIVisualEffectView!
    
    @IBOutlet weak var panelView: UIView!
    @IBOutlet weak var panelVisualEffectView: UIVisualEffectView!
    @IBOutlet weak var panGestureRecognizer: UIPanGestureRecognizer!

    @IBOutlet weak var panelTopInsetConstaint: NSLayoutConstraint!
    @IBOutlet weak var panelHeightConstraint: NSLayoutConstraint!

    private let topInsetFull: CGFloat = 120
    private let topInsetHalf: CGFloat = UIScreen.main.bounds.height / 2
    private let topInsetSmall: CGFloat =  UIScreen.main.bounds.height - 90
    private let bottomContentInsetPanel: CGFloat = 4

    private let containerScrollViewMaxYContentOffset: CGFloat = -80

    private var panelState: PanelDrawerState = .small

    // MARK: View's lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configurePanelView()

        panGestureRecognizer.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupInitialPanelConstaints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configurePanel(with: panelState)
    }


    // MARK: IBActions

    @IBAction func panGestureHandler(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: panelView)
        let velocity = sender.velocity(in: panelView)
        let y = panelTopInsetConstaint.constant + translation.y

        if (y >= topInsetFull && y <= topInsetSmall) {
            panelTopInsetConstaint.constant = y
            sender.setTranslation(CGPoint.zero, in: self.view)
        }

        if sender.state == .ended {
            switch panelState {
                case .full:
                    if (y >= topInsetHalf) {
                        panelState = .small
                    } else if (velocity.y > 0) {
                        panelState = .half
                    }
                case .half:
                    panelState = velocity.y > 0 ? .small : .full
                case .small:
                    if (y < topInsetHalf) {
                        panelState = .full
                    } else if (velocity.y < 0) {
                        panelState = .half
                    }
            }
            configurePanel(with: panelState)
        }
    }

    // MARK: Private

    private func configure() {

        if let mainController = mainController {
            addChild(mainController)
            mainController.view.frame = mainView.bounds
            mainView.addSubview(mainController.view)
            mainController.didMove(toParent: self)
        }

        addChild(panelDrawerController)
        panelDrawerController.view.frame = panelVisualEffectView.contentView.bounds
        panelVisualEffectView.contentView.addSubview(panelDrawerController.view)
        panelDrawerController.didMove(toParent: self)

        panelScrollView = (panelDrawerController as? ScrollablePanelDrawer)?.scrollView
    }

    private func setupInitialPanelConstaints() {
        panelView.isHidden = false
        panelHeightConstraint.constant = UIScreen.main.bounds.height - topInsetFull + bottomContentInsetPanel

        panelTopInsetConstaint.constant = topInsetSmall
        panelState = .small
    }

    private func configurePanel(with state: PanelDrawerState) {
        panelScrollView?.isScrollEnabled = (state == .full)
        animatePanel(with: state)
    }

    private func animatePanel(with state: PanelDrawerState) {
        UIView.animate(withDuration: 0.7,
                       delay: 0.0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1.0,
                       options: [.allowUserInteraction, .curveEaseIn]) {
            switch state {
                case .full:
                    self.panelTopInsetConstaint.constant = self.topInsetFull
                case .half:
                    self.panelTopInsetConstaint.constant = self.topInsetHalf
                case .small:
                    self.setupInitialPanelConstaints()
            }
            self.view.layoutIfNeeded()
        }
    }


    private func configurePanelView() {
        panelView.layer.configureLayerShadow()
        panelVisualEffectView.layer.configureCorners(maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        panelHandlerView.layer.cornerRadius = panelHandlerView.layer.bounds.height / 2
    }

}

extension PanelDrawerController: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {

        guard let gesture = gestureRecognizer as? UIPanGestureRecognizer,
              let scrollView = panelScrollView else { return false }

        let direction = gesture.velocity(in: view).y
        let y = panelTopInsetConstaint.constant

        let scrollContentOffset = scrollView.contentOffset

        if (y == topInsetFull && scrollContentOffset.y <= 0 && direction > 0) || (y == topInsetSmall) || (y == topInsetHalf) {
            scrollView.isScrollEnabled = false
        } else {
            scrollView.isScrollEnabled = true
        }

        return false
    }

}


private extension CALayer {

    func configureLayerShadow() {
        masksToBounds = false
        shadowColor = UIColor.black.cgColor
        shadowOffset = CGSize(width: 0, height: 2)
        shadowRadius = 8
        shadowOpacity = 0.24
    }

    func configureCorners(maskedCorners: CACornerMask) {
        cornerRadius = 24
        self.maskedCorners = maskedCorners
    }

}
