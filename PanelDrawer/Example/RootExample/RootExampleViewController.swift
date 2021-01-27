//
//  RootExampleViewController.swift
//  PanelDrawer
//
//  Created by Александр on 27.01.2021.
//

import UIKit

class RootExampleViewController: UIViewController {

    private var transition: PanelTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //presentExample()
    }
    
    @IBAction func valueChanged(_ sender: Any) {
        //presentExample()
        presentTableExample()
    }
    
    private func presentExample() {
        let anotherExampleSb = UIStoryboard(name: "RootExample", bundle: nil)
        let anotherVC = anotherExampleSb.instantiateViewController(withIdentifier: "AnotherExampleController")
        
        transition = PanelTransition(presented: anotherVC, presenting: self)
        anotherVC.transitioningDelegate = transition
        anotherVC.modalPresentationStyle = .custom
        present(anotherVC, animated: true)
    }

    private func presentTableExample() {
        let tableExampleSb = UIStoryboard(name: "TableExample", bundle: nil)
        let tableVC = tableExampleSb.instantiateInitialViewController()!
        transition = PanelTransition(presented: tableVC, presenting: self)
        tableVC.transitioningDelegate = transition
        tableVC.modalPresentationStyle = .custom
        present(tableVC, animated: true)
    }
    
}
