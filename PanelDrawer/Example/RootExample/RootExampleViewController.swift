//
//  RootExampleViewController.swift
//  PanelDrawer
//
//  Created by Александр on 27.01.2021.
//

import UIKit

class RootExampleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentSomething()
    }
    
    private func presentSomething() {
        
        let anotherExampleSb = UIStoryboard(name: "RootExample", bundle: nil)
        let anotherVC = anotherExampleSb.instantiateViewController(withIdentifier: "AnotherExampleController")
        present(anotherVC, animated: true)
    }

}
