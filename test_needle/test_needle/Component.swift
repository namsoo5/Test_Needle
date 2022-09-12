//
//  Component.swift
//  test_needle
//
//  Created by 김남수 on 2022/09/09.
//

import Foundation
import NeedleFoundation
import UIKit

final class RootComponent: BootstrapComponent {
    var prefixTitle: String { "당신은..." }
    var someProperty: String { "어떤 프로퍼티" }
    
    var rootViewController: UIViewController {
        ViewController(
            robot: robotComponent(id: ),
            people: peopleComponent(id: )
        )
    }
    
    // MARK: 단순반환
    //    var robotComponent: RobotComponent {
    //        RobotComponent(parent: self, id)
    //    }
    
    //    var peopleComponent: PeopleComponent {
    //        PeopleComponent(parent: self)
    //    }
    
    // MARK: 값 전달 필요한경우
    private func robotComponent(id: Int) -> any RobotBuilder {
        RobotComponent(parent: self, id: id)
    }
    
    private func peopleComponent(id: Int) -> any PeopleBuilder {
        PeopleComponent(parent: self, id: id)
    }
}

// MARK: - People

protocol PeopleBuilder {
    var peopleViewContoller: UIViewController { get }
}

protocol PeopleDependency: Dependency {
    var prefixTitle: String { get }
    var someProperty: String { get }
}

final class PeopleComponent: Component<PeopleDependency>, PeopleBuilder {
    private let id: Int
    init(parent: Scope, id: Int) {
        self.id = id
        super.init(parent: parent)
    }
    
    var peopleViewContoller: UIViewController {
        SecondViewController(viewModel: viewModel)
    }
    
    var viewModel: ViewModel {
        PeopleViewModel(text: "id: \(id)인\n \(dependency.prefixTitle)사람 입니다 🙆")
    }
}
       
// MARK: - Robot

protocol RobotBuilder {
    var robotViewContoller: UIViewController { get }
}

protocol RobotDependency: Dependency {
    var prefixTitle: String { get }
}

final class RobotComponent: Component<RobotDependency>, RobotBuilder {
    private let id: Int
    init(parent: Scope, id: Int) {
        self.id = id
        super.init(parent: parent)
    }
    
    var robotViewContoller: UIViewController {
        SecondViewController(viewModel: viewModel)
    }
    
    var viewModel: ViewModel {
        mutableViewModel
    }
}

extension RobotComponent {
    var mutableViewModel: ViewModel {
        shared { RobotViewModel(text: "id: \(id)인\n \(dependency.prefixTitle)로봇 입니다 🤖") }
    }
}
