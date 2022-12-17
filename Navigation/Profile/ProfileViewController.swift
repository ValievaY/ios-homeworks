

import UIKit
import StorageService

class ProfileViewController: UIViewController {
    
    lazy var avatarView: UIImageView = {
        let avatarView = UIImageView()
        avatarView.image = UIImage (named: "fox")
        avatarView.clipsToBounds = true
        avatarView.isHidden = true
        avatarView.layer.cornerRadius = 50
        avatarView.layer.borderWidth = 3
        avatarView.layer.borderColor = UIColor.white.cgColor
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        return avatarView
    }()
    
    lazy var backgroundView: UIImageView = {
        let backgroundView = UIImageView()
        backgroundView.backgroundColor = .gray
        backgroundView.frame = self.avatarView.bounds
        backgroundView.isHidden = true
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()
    
    lazy var xmarkView: UIImageView = {
        let xmarkView = UIImageView()
        xmarkView.image = UIImage(systemName: "xmark")
        xmarkView.tintColor = .black
        xmarkView.alpha = 0
        xmarkView.isHidden = true
        xmarkView.isUserInteractionEnabled = true
        xmarkView.translatesAutoresizingMaskIntoConstraints = false
        return xmarkView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "ProfileHeaderViewID")
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosCustomCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let photosController = PhotosViewController()
    
    var postView = [
        Post(author: "HBO.official", descriptionText: "HBO показал нагнетающий атмосферу тизер 7 эпизода «Дома дракона»", image: "dragon", likes: 100, views: 120),
        Post(author: "HBO.official", descriptionText: "Канал HBO представил дебютный тизер сериала-адаптации The Last of Us, премьера которого намечена на начало 2023 года.", image: "last of us", likes: 110, views: 130),
        Post(author: "Netflix.official", descriptionText: "Netflix опубликовал короткий ролик, в котором можно взглянуть на некоторые сцены из грядущего второго сезона шоу «Викинги: Вальхалла» (Vikings: Valhalla).", image: "vikings", likes: 100, views: 120),
        Post(author: "Netflix.official", descriptionText: "Netflix опубликовал второй трейлер мини-сериала «Монстр: История Джеффри Дамера» (Monster: The Jeffrey Dahmer Story). Роль Дамера исполнил Эван Питерс, известный по роли Ртути в фильмах о «Людях Икс».", image: "monster", likes: 110, views: 130),
    ]
    
    private var avatarViewWidthConstraint: NSLayoutConstraint?
    private var avatarViewHeightConstraint: NSLayoutConstraint?
    private var avatarViewLeadingAnchor: NSLayoutConstraint?
    private var avatarViewTopAnchor: NSLayoutConstraint?
    private var backgroundViewWidthConstraint: NSLayoutConstraint?
    private var backgroundViewHeightConstraint: NSLayoutConstraint?
    private var backgroundViewTopAnchor: NSLayoutConstraint?
    private var backgroundViewLeadingAnchor: NSLayoutConstraint?
    
    private var isAvatarViewIncreased = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(backgroundView)
        view.addSubview(xmarkView)
        view.addSubview(avatarView)
        setupConstraints()
        setupXmarkGesture()
#if DEBUG
    view.backgroundColor = .lightGray
#else
        view.backgroundColor = .systemBlue
#endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupConstraints() {
        
        avatarViewWidthConstraint = avatarView.widthAnchor.constraint(equalToConstant: 100)
        avatarViewHeightConstraint = avatarView.heightAnchor.constraint(equalToConstant: 100)
        avatarViewLeadingAnchor = avatarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        avatarViewTopAnchor = avatarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 46)
        
        backgroundViewWidthConstraint = backgroundView.widthAnchor.constraint(equalToConstant: 100)
        backgroundViewHeightConstraint = backgroundView.heightAnchor.constraint(equalToConstant: 100)
        backgroundViewLeadingAnchor = backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        backgroundViewTopAnchor = backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 46)
        
        NSLayoutConstraint.activate([
            
            avatarViewTopAnchor,
            avatarViewLeadingAnchor,
            avatarViewWidthConstraint,
            avatarViewHeightConstraint,
            
            backgroundViewTopAnchor,
            backgroundViewLeadingAnchor,
            backgroundViewWidthConstraint,
            backgroundViewHeightConstraint,
            
            xmarkView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            xmarkView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].compactMap({ $0 }))
    }
    
     private func avatarAnimation() {
        
        self.avatarViewWidthConstraint?.constant = self.isAvatarViewIncreased ? 100 : self.view.bounds.width
        self.avatarViewHeightConstraint?.constant = self.isAvatarViewIncreased ? 100 : self.view.bounds.width
        self.avatarViewLeadingAnchor?.constant = self.isAvatarViewIncreased ? 16 : 0
        self.avatarViewTopAnchor?.constant = self.isAvatarViewIncreased ? 46 : self.view.bounds.midY - self.view.bounds.width/2
        
        self.backgroundViewWidthConstraint?.constant = self.isAvatarViewIncreased ? 100 : self.view.bounds.width
        self.backgroundViewHeightConstraint?.constant = self.isAvatarViewIncreased ? 100 : self.view.bounds.height
        self.backgroundViewLeadingAnchor?.constant = self.isAvatarViewIncreased ? 16 : 0
        self.backgroundViewTopAnchor?.constant = self.isAvatarViewIncreased ? 46 : 0

        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: .curveEaseInOut) {
            self.avatarView.layer.cornerRadius = 0
            self.backgroundView.alpha = 0.8
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.isAvatarViewIncreased.toggle()
        }
    }
    
    private func xmarkAnimation() {
        UIView.animate(withDuration: 0.3,
                       delay: 0.5) {
            self.xmarkView.alpha = 1.0
        }
    }
    
    private func setupXmarkGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapXmark(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
       xmarkView.addGestureRecognizer(tapGestureRecognizer)
        }
    
    @objc func avatarTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        avatarView.isHidden.toggle()
        backgroundView.isHidden.toggle()
        xmarkView.isHidden.toggle()
        avatarAnimation()
        xmarkAnimation()
    }
    
    @objc func didTapXmark (_ gestureRecognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5) {
            self.avatarAnimation()
            self.avatarView.layer.cornerRadius = 50
            self.xmarkView.isHidden = true
            self.backgroundView.isHidden = true
        } completion: { _ in
            self.avatarView.isHidden = true
        }
    }
}
    
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return postView.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCustomCell", for: indexPath) as? PhotosTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
         return cell
        }
        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }

            let post = self.postView[indexPath.row]
            let viewModel = CustomTableViewCell.ViewPost(author: post.author, description: post.descriptionText, image: UIImage(named: post.image), likes: post.likes, views: post.views)
            cell.setup(with: viewModel)
            return cell
        }
       return tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
    }
    
   func tableView (_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProfileHeaderViewID") as? ProfileHeaderView else {
                return nil
            }
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(avatarTapGesture(_:)))
                tapGestureRecognizer.numberOfTapsRequired = 1
               headerView.avatarImageView.addGestureRecognizer(tapGestureRecognizer)
            
            headerView.contentView.backgroundColor = .lightGray
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.section == 0, indexPath.row == 0 {
                return 160
            }

            return UITableView.automaticDimension
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.navigationController?.pushViewController(photosController, animated: true)
        }
    }
}
    
  
