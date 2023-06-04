//
//  FrameworkListViewModel.swift
//  AppleFrameworkPractice
//
//  Created by YUJIN KWON on 2023/06/04.
//

import Foundation
import Combine

final class FrameworkListViewModel {
//    Data
    init(itmes: [AppleFramework], selectedItem: AppleFramework? = nil) {
        self.items = CurrentValueSubject(itmes)
        self.selectedItem = CurrentValueSubject(selectedItem)
    }
    
    let items: CurrentValueSubject<[AppleFramework], Never>
    let selectedItem: CurrentValueSubject<AppleFramework?, Never>
    
//    User Action
    func didSelect(at indexPath: IndexPath) {
        let item = items.value[indexPath.item]
        selectedItem.send(item)
    }
}
