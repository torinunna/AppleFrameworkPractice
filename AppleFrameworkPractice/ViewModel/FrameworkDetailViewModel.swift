//
//  FrameworkDetailViewModel.swift
//  AppleFrameworkPractice
//
//  Created by YUJIN KWON on 2023/06/04.
//

import Foundation
import Combine

final class FrameworkDetailViewModel {
    
//    Data
    init(framework: AppleFramework) {
        self.framework = CurrentValueSubject(framework)
    }
    
    let framework: CurrentValueSubject<AppleFramework, Never>
    
//    User Action
    let didSelect = PassthroughSubject<AppleFramework, Never>()
    
    func LearnMoreBtnPressed() {
        didSelect.send(framework.value)
    }
    
}
