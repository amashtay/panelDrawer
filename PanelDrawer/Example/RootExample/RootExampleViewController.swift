//
//  RootExampleViewController.swift
//  PanelDrawer
//
//  Created by Александр on 27.01.2021.
//

import UIKit

class RootExampleViewController: UIViewController {

    private let transition = PanelTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentExample()
    }
    
    @IBAction func valueChanged(_ sender: Any) {
        presentExample()
    }
    private func presentExample() {
        
        let anotherExampleSb = UIStoryboard(name: "RootExample", bundle: nil)
        let anotherVC = anotherExampleSb.instantiateViewController(withIdentifier: "AnotherExampleController")
        anotherVC.transitioningDelegate = transition
        anotherVC.modalPresentationStyle = .custom
        present(anotherVC, animated: true)
    }

}
