//
//  TableExampleController.swift
//  PanelDrawer
//
//  Created by Александр Тонхоноев on 19.01.2021.
//

import UIKit

class TableExampleController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var delegateChangedScrollViewContentOffsetCompletion: ((CGPoint) -> ())?

}

extension TableExampleController: UITableViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegateChangedScrollViewContentOffsetCompletion?(scrollView.contentOffset)
    }

}

extension TableExampleController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        120
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }

}

extension TableExampleController: PanelDrawerDelegate {

    func panelDrawerChangedState(with state: PanelDrawerState) {
        switch state {
            case .full:
                tableView.isScrollEnabled = true
            default:
                tableView.isScrollEnabled = false
        }
    }

}
