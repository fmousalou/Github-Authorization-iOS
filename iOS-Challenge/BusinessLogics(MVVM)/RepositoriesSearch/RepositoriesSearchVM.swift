//
//  RepositoriesSearchVM.swift
//  iOS-Challenge
//
//  Created by Saeed Dehshiri on 4/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

class RepositoriesSearchVM {
    
    weak var vc: RepositoriesSearchVC!
    var items: [SearchRepositoriesItemResponse] = []
    
    init(_ vc: RepositoriesSearchVC) {
        self.vc = vc
    }
    
    func loadData() {
        
    }
    
    func getData(q: String) {
        SearchRepositoriesNetwork(q: q)
            .execute(onSuccess: { [weak self] (response) in
                self?.items = response.items
                self?.vc.reloadData()
            }, onError: { (error) in
                print(error)
            }) { (connectionError) in
                print(connectionError)
        }
    }
    
}
