//
//  SaveMyCartViewModel.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 25/12/22.
//

import Foundation
import RealmSwift


protocol SaveMyCartDelegate: AnyObject {
    func showSaveMyCart()
}

class SaveMyCartViewModel: BaseViewModel {
    private weak var delegate: SaveMyCartDelegate? = nil
    var saveMyCart: Results<MyCartDatabaseModel>? = nil
    var myCart = [MyCartModel]()
    
    init(delegate: SaveMyCartDelegate) {
        self.delegate = delegate
    }
    
    func saveMyCartModel(model: MyCartDatabaseModel) {
        dataBase.saveMyCarts(model: model)
        delegate?.showSaveMyCart()
    }
    
    func saveMyCartToDatabase(){
        var list: [MyCartModel] = []
        let models = dataBase.getSavedMyCarts()
        models?.forEach{item in
            list.append(item.toModel())
        }
        self.myCart = list
    }

}
