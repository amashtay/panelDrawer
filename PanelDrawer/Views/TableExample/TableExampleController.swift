//
//  TableExampleController.swift
//  PanelDrawer
//
//  Created by Александр Тонхоноев on 19.01.2021.
//

import UIKit

class TableExampleController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var scrollViewChangedContentOffsetCompletion: ((CGPoint) -> ())?

}

extension TableExampleController: UITableViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewChangedContentOffsetCompletion?(scrollView.contentOffset)
    }

}

extension TableExampleController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        120
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        cell.backgroundColor = UIColor.clear
        return cell
    }

}

extension TableExampleController: PanelDrawerScrollDelegate {

    func panelDrawerChangedState(with scrollingEnabled: Bool) {
        tableView.isScrollEnabled = scrollingEnabled
    }

}
