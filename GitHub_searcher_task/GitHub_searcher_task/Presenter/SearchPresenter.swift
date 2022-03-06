//
//  SearchPresenter.swift
//  GitHub_Searcher
//
//  Created by edisonlin on 2022/3/5.
//

import Foundation
import Alamofire

protocol SearchPresenterDelegate: AnyObject {
    func didFetch()
}

class SearchPresenter {
    
    weak var delegate: SearchPresenterDelegate?
    private var items: [UserItemsModel] = []
    var nextPath: String?
    var itemsCount: Int {
        return items.count
    }
    
    func fetchUsers(userName: String) {
        
        self.items = []
        self.nextPath = nil
        let parameters: Parameters = ["q" : userName]
        
        APIService.shared.executeQuery(url: Constant.searchUsersURL, method: .get, parameters: parameters, headers: nil, encoding: URLEncoding.default) { [weak self] (result: Result<Model, Error>) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                for items in data.data.items {
                    self.items.append(items)
                }
                self.nextPath = data.nextPath
                self.delegate?.didFetch()
            case .failure(let error):
                print("取得資料失敗", error)
            }
        }
    }
    
    func pagination() {
        
        guard
            let nextPath = nextPath,
            let name = nextPath.getQueryStringParameter(param: "q"),
            let page = nextPath.getQueryStringParameter(param: "page")
        else { return }
        
        let parameters: Parameters = ["q" : name, "page" : page]
        
        APIService.shared.executeQuery(url: Constant.searchUsersURL, method: .get, parameters: parameters, headers: nil, encoding: URLEncoding.default) { (result: Result<Model, Error>) in
            switch result {
            case .success(let data):
                for items in data.data.items {
                    self.items.append(items)
                }
                self.nextPath = data.nextPath
                self.delegate?.didFetch()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func data(row: Int) -> UserItemsModel{
        return items[row]
    }
}
