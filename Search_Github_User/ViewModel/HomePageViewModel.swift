//
//  HomePageViewModel.swift
//  Search_Github_User
//
//  Created by Subhankar Ghosh on 17/05/20.
//  Copyright © 2020 Subhankar Ghosh. All rights reserved.
//

import Foundation

class HomePageViewModel {
    var viewDidLoad: ()->() = {}
    var reloadData: ()->() = {}
    
    var searchResults: SearchResult?
    var currentSearchText: String = ""
    var currentPage: Int = 1
    var currentUsersCount: Int = 0
    
    var searchUser: String = "" {
        didSet {
            fetchData(with: self.searchUser, page: 1)
        }
    }
    
    init() {
        viewDidLoad = { [weak self] in
            if let count = self?.searchResults?.items.count, count > 0 {
                self?.reloadData()
            }
        }
    }

    func fetchData(with query: String, page: Int) {
        APIManager.fetchUsers(with: query, page: page) { [weak self] (result) in
            do {
                if let dataType = try? result.get() {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(SearchResult.self, from: dataType)
                    if self?.currentPage == 1 {
                        self?.searchResults = data
                    } else if (self?.currentPage ?? 0 > 1) {
                        for obj in data.items {
                            if !(self?.searchResults?.items.contains(where: {$0.userName == obj.userName}) ?? true) {
                                self?.searchResults?.items.append(obj)
                            }
                        }
                    }
                    self?.reloadData()
                }
            } catch {
                print("Something went wrong")
            }
        }
    }
    
    func clearData() {
        searchResults = nil
        reloadData()
    }
}
