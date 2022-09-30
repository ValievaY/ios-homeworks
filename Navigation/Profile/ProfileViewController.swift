

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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        
        let post = self.postView[indexPath.row]
        let viewModel = CustomTableViewCell.ViewPost(author: post.author, description: post.descriptionText, image: UIImage(named: post.image), likes: post.likes, views: post.views)
        cell.setup(with: viewModel)
        return cell
    }
    
    func tableView (_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProfileHeaderViewID") as? ProfileHeaderView else {
            return nil
        }
        headerView.contentView.backgroundColor = .lightGray
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        250
    }
}
    
  
