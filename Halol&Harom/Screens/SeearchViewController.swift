//
//  SeearchViewController.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 29/01/23.
//

import UIKit

class SeearchViewController: UIViewController, UISearchResultsUpdating {
    
    var codes = ecodes {
        didSet {
            tableView.reloadData()
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            codes = ecodes
            return
        }
        codes = ecodes.filter { $0.eCode.lowercased().contains(filter.lowercased()) }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.titleView = twoLineTitleView(text: "Qidirish", color: .black)
        configureTableView()
        configureSearchController()
        //navigationController?.backgroundColor(backgroundcolor: UIColor.init(hex: "303030"), tintColor: .white)
    }
    
    let tableView = UITableView()
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = true
        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: ResultTableViewCell.identifier)
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Ecode orqali izlang ..."
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
}

extension SeearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return codes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath) as? ResultTableViewCell else { return UITableViewCell() }
        cell.setDataForSearch(ecode: codes[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
