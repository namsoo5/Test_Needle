//
//  ViewModel.swift
//  test_needle
//
//  Created by 김남수 on 2022/09/10.
//

import Foundation

protocol ViewModel {
    var text: String { get }
}

final class RobotViewModel: ViewModel {
    let text: String
    
    init(text: String) {
        self.text = text
    }
}

final class PeopleViewModel: ViewModel {
    let text: String
    
    init(text: String) {
        self.text = text
    }
}
