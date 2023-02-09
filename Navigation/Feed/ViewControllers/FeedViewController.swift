

import UIKit

class FeedViewController: UIViewController {
    
    weak var coordinator: FeedCoordinatorProtocol?
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var buttonFirst: UIButton = {
        let button = UIButton()
        button.setTitle("View post", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 14
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonSecond: UIButton = {
        let button = UIButton()
        button.setTitle("View post", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 14
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.textAlignment = .center
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 12
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 25
        label.backgroundColor = .systemGray
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var viewModel = FeedViewModel()
    
    private lazy var checkGuessButton = CustomButton(title: "Guess word",
                                                     cornerRadius: 10,
                                                     titleColor: .white,
                                                     color: .systemBlue,
                                                     buttonAction: { [self] in
        if textField.hasText {
            viewModel.check(textField.text ?? "")
        } else {
            label.backgroundColor = .systemGray
            print ("TextField is empty")
        }
    })
    
    init(coordinator: FeedCoordinatorProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        view.backgroundColor = .white
        addTargets()
        setupConstraints()
        bindViewModel()
    }
    
    private func bindViewModel() {
        self.viewModel.wordDidEntered = { [weak self] viewModel in
            self?.label.backgroundColor = viewModel.checkResult
        }
    }
    
   private func addTargets() {
        buttonFirst.addTarget(self, action: #selector(toPostView), for: .touchUpInside)
       buttonSecond.addTarget(self, action: #selector(toPostView), for: .touchUpInside)
    }
    
   private func setupConstraints() {

       view.addSubview(stackView)
       view.addSubview(textField)
       view.addSubview(checkGuessButton)
       view.addSubview(label)
       stackView.addArrangedSubview(buttonFirst)
       stackView.addArrangedSubview(buttonSecond)
       
       checkGuessButton.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            checkGuessButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            checkGuessButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            checkGuessButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 50),
            
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.widthAnchor.constraint(equalToConstant: 50),
            label.heightAnchor.constraint(equalToConstant: 50),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func toPostView() {
        coordinator?.toPostView()
    }
}
