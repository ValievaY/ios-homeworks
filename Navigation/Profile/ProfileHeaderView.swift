//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Apple Mac Air on 28.08.2022.
//

import UIKit
import SnapKit

class ProfileHeaderView: UITableViewHeaderFooterView  {
    
    var statusText: String = ""
    
     lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "fox.jpg")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameLabel.textColor = .black
        nameLabel.text = "Yulia Valieva"
        return nameLabel
    }()
    
    private lazy var statusLabel: UILabel = {
        let status = UILabel()
        status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        status.textColor = .gray
        status.text = "Waiting for something..."
        return status
    }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize (width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        return button
    }()
    
    private lazy var statusTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.textAlignment = .center
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.cornerRadius = 12
        text.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        text.textColor = .black
        text.placeholder = "write something"
        return text
    }()
    
    private lazy var changeTitle: UIButton = {
        let titleButton = UIButton()
        titleButton.setTitle("Profile", for: .normal)
        titleButton.setTitleColor(UIColor.black, for: .normal)
        titleButton.backgroundColor = .lightGray
        return titleButton
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addView()
        setupConstraints()
        addTargets()
        changeStatusText()
    }
    
    required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
    
    func addView() {
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(setStatusButton)
        addSubview(statusTextField)
        addSubview(changeTitle)
    }
    
    func setupConstraints() {
        
        avatarImageView.snp.makeConstraints ({ make in
            make.top.equalTo(changeTitle.snp.bottom)
            make.left.equalToSuperview().offset(16)
            make.height.width.equalTo(100)
        })
        
        fullNameLabel.snp.makeConstraints({ make in
            make.top.equalTo(changeTitle.snp.bottom).offset(27)
            make.centerX.equalToSuperview()
        })
        
        setStatusButton.snp.makeConstraints ({ make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(50)
        })
        
        statusLabel.snp.makeConstraints ({ make in
            make.bottom.equalTo(setStatusButton.snp.top).offset(-50)
            make.left.equalTo(avatarImageView.snp.right).offset(25)
        })
        
        statusTextField.snp.makeConstraints ({ make in
            make.bottom.equalTo(setStatusButton.snp.top).offset(-5)
            make.top.equalTo(statusLabel.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-16)
            make.left.equalTo(avatarImageView.snp.right).offset(25)
            make.height.equalTo(40)
        })
        
        changeTitle.snp.makeConstraints ({ make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
        })
    }
    
    func addTargets() {
        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
     }
    
    func changeStatusText() {
         setStatusButton.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
     }
    
    @objc func buttonPressed() {
        print(statusLabel.text ?? "No text")
        statusLabel.text = statusTextField.text
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = statusTextField.text ?? "No text"
    }
}
