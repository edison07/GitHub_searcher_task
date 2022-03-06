//
//  ViewController.swift
//  GitHub_searcher_task
//
//  Created by edisonlin on 2022/3/6.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    private let presenter = SearchPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        presenter.delegate = self
        collectionView.register(nib: UINib(nibName: "ResultCollectionViewCell", bundle: nil), forCellWithClass: ResultCollectionViewCell.self)
    }


}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let name = searchBar.text else { return }
        presenter.fetchUsers(userName: name)
        self.view.endEditing(true)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == presenter.itemsCount - 1 {
            presenter.pagination()
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: ResultCollectionViewCell.self, for: indexPath)
        let data = presenter.data(row: indexPath.row)
        cell.setUI(name: data.name, avatar: data.avatarURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.itemsCount
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
}

extension ViewController: SearchPresenterDelegate {
    func didFetch() {
        collectionView.reloadData()
    }
}
