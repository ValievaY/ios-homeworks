//
//  LogInViewController.swift
//  Navigation
//
//  Created by Apple Mac Air on 20.09.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var logoImage: UIImageView = {
          let logoImage = UIImageView()
          logoImage.image = UIImage (named: "logo")
          logoImage.translatesAutoresizingMaskIntoConstraints = false
          return logoImage
      }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = 10
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.spacing = 0.5
        stackView.backgroundColor = .lightGray
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var logIn: UITextField = {
        let logIn = UITextField()
        logIn.tag = 0
        logIn.textColor = .black
        logIn.backgroundColor = .systemGray6
        logIn.textAlignment = .left
        logIn.placeholder = "  Email or phone"
        logIn.tintColor =  UIColor (named: "MyBlueColor")
        logIn.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        logIn.autocapitalizationType = .none
        logIn.clearButtonMode = .whileEditing
        logIn.delegate = self
        logIn.translatesAutoresizingMaskIntoConstraints = false
        return logIn
    }()
    
    private lazy var password: UITextField = {
        let password = UITextField()
        password.tag = 1
        password.textColor = .black
        password.backgroundColor = .systemGray6
        password.textAlignment = .left
        password.placeholder = "  Password"
        password.tintColor = UIColor (named: "MyBlueColor")
        password.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        password.autocapitalizationType = .none
        password.isSecureTextEntry = true
        password.clearButtonMode = .whileEditing
        password.delegate = self
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    private lazy var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    private lazy var button = CustomButton(title: "Log In",
                                           cornerRadius: 10,
                                           titleColor: .white,
                                           color: UIColor(patternImage: UIImage (named: "blue_pixel")!),
                                           buttonAction: { [self] in
        if loginDelegate?.check(logInText ?? "No text", passwordText ?? "No text") == true && userService?.authorization(logInText ?? "No text") != nil {
            self.navigationController?.pushViewController(profileViewController, animated: true)
        } else {
            self.present(alert, animated: true, completion: nil)
            print ("wrong login")
        }
    })
    
    private lazy var passwordGuessingButton = CustomButton(title: "Подобрать пароль", cornerRadius: 10, titleColor: .systemGray, color: .systemGray5, buttonAction: {
        self.activityIndicator.startAnimating()
        DispatchQueue.global().async {
            self.passwordText = BruteForce().bruteForce(passwordToUnlock: "1234")
            DispatchQueue.main.async { [self] in
                password.text = passwordText
                password.isSecureTextEntry = false
                activityIndicator.stopAnimating()
            }
        }
    })
    
    private let alert = UIAlertController(title: "Неверный логин или пароль", message: "",  preferredStyle: .alert)
    
    private var logInText: String?
    
    private var passwordText: String?
    
    private let profileViewController = ProfileViewController()
    
    private var userService: UserService?
    
    var loginDelegate: LoginViewControllerDelegate?
    
    private var checkResult: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        setupGestures()
        addSubview()
        setupConstraints()
        setupAlert()
#if DEBUG
        userService = TestUserService()
#else
        userService = CurrentUserService()
#endif
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHidingKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didHideKeyboard(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func addSubview() {
        stackView.addArrangedSubview(logIn)
        stackView.addArrangedSubview(password)
        view.addSubview(scrollView)
        scrollView.addSubview(logoImage)
        scrollView.addSubview(stackView)
        scrollView.addSubview(button)
        scrollView.addSubview(passwordGuessingButton)
        scrollView.addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        
        button.translatesAutoresizingMaskIntoConstraints = false
        passwordGuessingButton.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            logoImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
             logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             logoImage.heightAnchor.constraint(equalToConstant: 100),
             logoImage.widthAnchor.constraint(equalToConstant: 100),
            
            stackView.heightAnchor.constraint(equalToConstant: 100),
             stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
             stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
             stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            activityIndicator.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: stackView.centerYAnchor,constant: 25),
            
            passwordGuessingButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            passwordGuessingButton.heightAnchor.constraint(equalToConstant: 50),
            passwordGuessingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordGuessingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            button.topAnchor.constraint(equalTo: passwordGuessingButton.bottomAnchor, constant: 16),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
           button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func setupAlert() {
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            _ in
            print("OK")
        }))
    }
    
    @objc private func didShowKeyboard(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let loginButtonBottomPointY =  button.frame.origin.y + button.frame.height
            let keyboardOriginY = view.frame.height - keyboardHeight
            
            let yOffset = keyboardOriginY < loginButtonBottomPointY
            ? loginButtonBottomPointY - keyboardOriginY + 16
            : 0
            scrollView.contentOffset = CGPoint(x: 0, y: yOffset)
        }
    }
    
    @objc private func didHideKeyboard(_ notification: Notification) {
        forcedHidingKeyboard()
    }
    
    @objc private func forcedHidingKeyboard() {
        view.endEditing(true)
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 0 {
            logInText = textField.text
            profileViewController.user = userService?.authorization(logInText ?? "No text")
        }
        if textField.tag == 1 {
            passwordText = textField.text
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        print("\(textField.text ?? "No text")")
        if textField.tag == 0 {
            logInText = textField.text
        }
        if textField.tag == 1 {
            passwordText = textField.text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        forcedHidingKeyboard()
        return true
    }
}
