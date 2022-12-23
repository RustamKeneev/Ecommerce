//
//  ProductDetailHorizontalMenuCollectioView.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 19/12/22.
//

import Foundation
import UIKit

protocol SelectedProductDetailsCollectioViewItemProtocol: AnyObject {
    func selectItem(index: IndexPath)
}

class ProductDetailHorizontalMenuCollectioView: UICollectionView {
    
    private let categoryLayout = UICollectionViewFlowLayout()
    
    private lazy var viewModelProductDetail: ProductDetailViewModels = {
        return ProductDetailViewModels(delegate: self)
    }()
    
    weak var cellDelegate: SelectedProductDetailsCollectioViewItemProtocol?
    
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
        categoryLayout.scrollDirection = .vertical
        bounces = false
        showsHorizontalScrollIndicator = false
        
        viewModelProductDetail.fetchProductDetail()
        delegate = self
        dataSource = self
        register(HorizontalMenuCollectioViewProductDetailCell.self, forCellWithReuseIdentifier: "HorizontalMenuCollectioViewProductDetailCell")
        selectItem(at: [0,0], animated: true, scrollPosition: [])
    }
}

//MARK: - UICollectionViewDataSource
extension ProductDetailHorizontalMenuCollectioView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModelProductDetail.productDetailArrayData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalMenuCollectioViewProductDetailCell", for: indexPath) as? HorizontalMenuCollectioViewProductDetailCell else {return UICollectionViewCell()}
        let productDetailData = viewModelProductDetail.productDetailArrayData[indexPath.item]
        cell.setupData(productDetailPagingModel: productDetailData)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension ProductDetailHorizontalMenuCollectioView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected \(indexPath)")
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        cellDelegate?.selectItem(index: indexPath)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ProductDetailHorizontalMenuCollectioView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 138, height: 36)
    }
}

extension ProductDetailHorizontalMenuCollectioView: ProductDetailViewModelsDelegate{
    func loadProductdetail() {
        print("ProductDetailViewModelsDelegate loaded")
    }
}
