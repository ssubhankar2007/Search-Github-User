//
//  HomePageViewController.swift
//  Search_Github_User
//
//  Created by Subhankar Ghosh on 17/05/20.
//  Copyright © 2020 Subhankar Ghosh. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mTableView: UITableView!
    private let cellIdentifier = "userBasicInfoTableViewCell"
    var homePageViewModel: HomePageViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homePageViewModel = HomePageViewModel()
        observeEvents()
    }
    
    func observeEvents() {
        homePageViewModel?.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.mTableView.reloadData()
            }
        }
    }
}

extension HomePageViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.text?.count ?? 0 > 0 {
            searchBar.showsCancelButton = true
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            homePageViewModel?.currentSearchText = searchText
            homePageViewModel?.fetchData(with: searchText, page: 1)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        homePageViewModel?.currentSearchText = ""
        searchBar.resignFirstResponder()
        homePageViewModel?.clearData()
    }
}

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = homePageViewModel?.searchResults?.items.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? UserBasicInfoTableViewCell {
            if let data = homePageViewModel?.searchResults?.items[indexPath.row] {
                cell.configureCell(data: data)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let count = homePageViewModel?.searchResults?.items.count {
            if indexPath.row == count - 10 {
                homePageViewModel?.currentPage += 1
                homePageViewModel?.fetchData(with: homePageViewModel?.currentSearchText ?? "", page: homePageViewModel?.currentPage ?? 0)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

