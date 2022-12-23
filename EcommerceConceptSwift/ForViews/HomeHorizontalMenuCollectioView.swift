//
//  HomeHorizontalMenuCollectioView.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 11/12/22.
//

import Foundation
import UIKit

protocol SelectedCollectioViewItemProtocol: AnyObject {
    func selectItem(index: IndexPath)
}

class HomeHorizontalMenuCollectioView: UICollectionView {
    
    private let categoryLayout = UICollectionViewFlowLayout()
    
    private lazy var viewModelCategory: CategoryViewModels = {
        return CategoryViewModels(delegate: self)
    }()
    
    weak var cellDelegate: SelectedCollectioViewItemProtocol?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: categoryLayout)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        backgroundColor = .none
        translatesAutoresizingMaskIntoConstraints = false
        
        categoryLayout.minimumInteritemSpacing = 6
        categoryLayout.scrollDirection = .horizontal
        bounces = false
        showsHorizontalScrollIndicator = false
        
        viewModelCategory.fetchSCategory()
        
        delegate = self
        dataSource = self
        register(HorizontalMenuCollectioViewHomeCell.self, forCellWithReuseIdentifier: "HorizontalMenuCollectioViewHomeCell")
        selectItem(at: [0,0], animated: true, scrollPosition: [])
    }
}

//MARK: - UICollectionViewDataSource
extension HomeHorizontalMenuCollectioView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModelCategory.catalogsArrayData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalMenuCollectioViewHomeCell", for: indexPath) as? HorizontalMenuCollectioViewHomeCell else {return UICollectionViewCell()}
        let categoryData = viewModelCategory.catalogsArrayData[indexPath.item]
        cell.setupData(categoryModel: categoryData)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension HomeHorizontalMenuCollectioView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected \(indexPath)")
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        cellDelegate?.selectItem(index: indexPath)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HomeHorizontalMenuCollectioView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 72, height: 72)
    }
}

extension HomeHorizontalMenuCollectioView: CategoryViewModelsDelegate{
    func loadCategory() {
        print("test")
    }
}
