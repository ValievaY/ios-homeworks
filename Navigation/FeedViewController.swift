

import UIKit

class FeedViewController: UIViewController {
    
    var post = Post(title: "New Post")
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("View post", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 14
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let postController = PostViewController().self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        view.backgroundColor = .white
        addTargets()
        setupConstraints()
    }
    
   func addTargets() {
        button.addTarget(self, action: #selector(toPostView), for: .touchUpInside)
    }
    
   func setupConstraints() {

       view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func toPostView() {
        self.navigationController?.pushViewController(postController, animated: true)
        postController.titlePost = post.title
    }
}
