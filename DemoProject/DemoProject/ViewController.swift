//
//  ViewController.swift
//  DemoProject
//
//  Created by Damian on 30.05.2024.
//

import UIKit

class ViewController: UITableViewController {
    
    var rows = Array(1...100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func insertRows() {
        guard let last = rows.last else { return }
        let items = Array(last + 1...last + 50)
        let indexPaths: [IndexPath] = items.map { .init(row: $0 - 1, section: 0) }
        self.rows.append(contentsOf: items)
        self.tableView.insertRows(at: indexPaths, with: .bottom)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource methods
extension ViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset
        let bottomOffset = CGPoint(
            x: 0,
            y: scrollView.contentSize.height - scrollView.frame.size.height + scrollView.contentInset.top + scrollView.contentInset.bottom
        )
        let bottomAchived = contentOffset.y >= (bottomOffset.y < 0 ? 0 : bottomOffset.y)
        
        if bottomAchived {
            self.insertRows()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return .init()
        }
        var cfg = cell.defaultContentConfiguration()
        cfg.text = rows[indexPath.row].description + " Mississippi"
        cell.contentConfiguration = cfg
        return cell
    }
}
