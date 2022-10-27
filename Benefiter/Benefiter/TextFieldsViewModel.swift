//
//  TextFieldsViewModel.swift
//  Benefiter
//
//  Created by Мария Изюменко on 20.10.2022.
//

import RxCocoa
import RxSwift

class TextFieldsViewModel {
    
    let topPriceFieldsSubject = BehaviorRelay<String?>(value: "")
    let topWeightFieldsSubject = BehaviorRelay<String?>(value: "")
    let centerPriceFieldsSubject = BehaviorRelay<String?>(value: "")
    let centerWeightFieldsSubject = BehaviorRelay<String?>(value: "")
    let calculateButton = BehaviorRelay<UIColor?>(value: .lightGray)
    let disposeBag = DisposeBag()

    
    var isValidForm: Observable<Bool> {
        return Observable.combineLatest(topPriceFieldsSubject,
                                        topWeightFieldsSubject,
                                        centerPriceFieldsSubject,
                                        centerWeightFieldsSubject) {
                                            topPrice,
                                            topWeight,
                                            centerPrice,
                                            centerWeight in
            guard topPrice != nil &&
                    topWeight != nil &&
                    centerPrice != nil &&
                    centerWeight != nil else { return false }
            
            return !(topPrice!.isEmpty) && !(topWeight!.isEmpty) && !(centerPrice!.isEmpty) && !(centerWeight!.isEmpty)
        }
    }
}

class BottomTextFields {
    
    let topPriceFieldsSubject = BehaviorRelay<String?>(value: "")
    let topWeightFieldsSubject = BehaviorRelay<String?>(value: "")
    let centerPriceFieldsSubject = BehaviorRelay<String?>(value: "")
    let centerWeightFieldsSubject = BehaviorRelay<String?>(value: "")
    let bottomPriceFieldsSubject = BehaviorRelay<String?>(value: "")
    let bottomWeightFieldsSubject = BehaviorRelay<String?>(value: "")
    let resultButton = BehaviorRelay<UIColor?>(value: .lightGray)
    var disposeBag = DisposeBag()
    
    var isValidBottomForm: Observable<Bool> {
        return Observable.combineLatest(topPriceFieldsSubject,
                                        topWeightFieldsSubject,
                                        centerPriceFieldsSubject,
                                        centerWeightFieldsSubject,
                                        bottomPriceFieldsSubject,
                                        bottomWeightFieldsSubject) { topPrice,
                                                                     topWeight,
                                                                     centerPrice,
                                                                     centerWeight,
                                                                     bottomPrice,
                                                                     bottomWeight in
            guard topPrice != nil && topWeight != nil && centerPrice != nil && centerWeight != nil && bottomPrice != nil && bottomWeight != nil else { return false }
            return !(topPrice!.isEmpty) && !(topWeight!.isEmpty) && !(centerPrice!.isEmpty) && !(centerWeight!.isEmpty) && !(bottomPrice!.isEmpty) && !(bottomWeight!.isEmpty)
        }
    }
}
