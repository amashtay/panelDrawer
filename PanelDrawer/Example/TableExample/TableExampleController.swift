//
//  TableExampleController.swift
//  PanelDrawer
//
//  Created by Александр Тонхоноев on 19.01.2021.
//

import UIKit

class TableExampleController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

}

extension TableExampleController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        120
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        //cell.backgroundColor = UIColor.clear
        return cell
    }

}

extension TableExampleController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let direction = scrollView.panGestureRecognizer.velocity(in: view).y
//        print(direction)
//        if (scrollView.contentOffset.y <= 0 && direction > 0) {
//            dismiss(animated: true, completion: nil)
//        }
//    }

}


extension TableExampleController: ScrollablePanelDrawer {

    var scrollView: UIScrollView? {
        tableView
    }

}
