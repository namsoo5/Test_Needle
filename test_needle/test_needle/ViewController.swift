//
//  ViewController.swift
//  test_needle
//
//  Created by 김남수 on 2022/09/09.
//

import UIKit

final class ViewController: UIViewController {
    private let questionLabel: UILabel = UILabel()
    private let stackView: UIStackView = UIStackView()
    private let peopleButton: UIButton = UIButton(configuration: .filled())
    private let robotButton: UIButton = UIButton(configuration: .filled())
    
    private let robotComponent: (Int) -> any RobotBuilder
    private let peopleComponent: (Int) -> any PeopleBuilder
    
    init(
        robot: @escaping (Int) -> any RobotBuilder,
        people: @escaping (Int) -> any PeopleBuilder
    ) {
        robotComponent = robot
        peopleComponent = people
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setLayout()
        setUI()
    }
    
    private func setLayout() {
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionLabel)
        questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        questionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: questionLabel.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 50).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        stackView.addArrangedSubview(peopleButton)
        stackView.addArrangedSubview(robotButton)
    }
    
    private func setUI() {
        questionLabel.text = "당신은 사람입니까?"
        stackView.spacing = 20
        peopleButton.setTitle("사람입니다", for: .normal)
        let peopleAction = UIAction { _ in
            self.tapPeople()
        }
        peopleButton.addAction(peopleAction, for: .touchUpInside)
        
        robotButton.setTitle("로_봇-입_니-다", for: .normal)
        let robotAction = UIAction { _ in
            self.tapRobot()
        }
        robotButton.addAction(robotAction, for: .touchUpInside)
    }
    
    private func tapPeople() {
        let selectedNum = [1,2,3,4,5,6,7,8].randomElement()!
        let viewController = peopleComponent(selectedNum).peopleViewContoller
        present(viewController, animated: true)
    }

    private func tapRobot() {
        let selectedNum = [1,2,3,4,5,6,7,8].randomElement()!
        let viewController = robotComponent(selectedNum).robotViewContoller
        present(viewController, animated: true)
    }
}

final class SecondViewController: UIViewController {
    private var titleLabel: UILabel = UILabel()
    private let viewModel: ViewModel?
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        titleLabel.font = .systemFont(ofSize: 40)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        titleLabel.text = viewModel?.text
    }
}
