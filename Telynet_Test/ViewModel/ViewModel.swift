//
//  ViewModel.swift
//  Telynet_Test
//
//  Created by Eduardo Herrera on 3/8/23.
//

import Foundation


@MainActor
public class ViewModel: ObservableObject {
    //model instance
    var model = Model()
    
    //to filter and sort
    @Published var accounts: [Account] = []
    
    //Text to search clients
    @Published var searchText = "" {
        didSet {
            filterBySearch()
        }
    }
    @Published var searchResults:  [Account] = []
    
    
    @Published var selectionOrderBy = AppStorages.orderBy {
        didSet {
            setupView()
        }
    }
    
    @Published var selectionFilterBy = AppStorages.filterBy {
        didSet {
            setupView()
        }
    }
    
    init() {
        //default
        setupView()
    }
    
    private func setupView() {
        AppStorages.filterBy = selectionFilterBy
        AppStorages.orderBy = selectionOrderBy
        dataFilter()
        dataOrder()
    }
    
    //setup Searchs
    private func filterBySearch() {
        searchResults = accounts.filter({$0.name.contains(searchText) || String($0.code).contains(searchText)})
        
    }
    
    private func dataFilter() {
        //check the selected configuration
        if selectionFilterBy == "Todos" {
            self.accounts = model.accounts
            
        } else {
            //chek options with ternary operator
            self.accounts = AppStorages.filterBy == "Visitados" ? model.accounts.filter({$0.visited == "1"}) :
                                                                   model.accounts.filter({$0.visited == "0"})
        }
    }
    
    private func dataOrder() {
        //chek options with ternary operator
        self.accounts = AppStorages.orderBy == "Nombre" ? accounts.sorted(by: {$0.name < $1.name}) :
                                                           accounts.sorted(by: {$0.code < $1.code})
    }
    
    
    
}
