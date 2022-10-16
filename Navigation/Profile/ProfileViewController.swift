

import UIKit

class ProfileViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(tableView)
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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
    
  
