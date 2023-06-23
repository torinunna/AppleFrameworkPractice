//
//  FrameworkDetailViewModelSwiftUI.swift
//  AppleFrameworkPractice
//
//  Created by YUJIN KWON on 2023/06/23.
//

import Foundation
import SwiftUI

final class FrameworkDetailViewModelSwiftUI: ObservableObject {
    @Published var framework: AppleFramework
    @Published var isSafariPresented: Bool = false
    
    init(framework: AppleFramework) {
        self.framework = framework
    }
}
