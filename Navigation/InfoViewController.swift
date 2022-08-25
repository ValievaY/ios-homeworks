
import UIKit

class InfoViewController: UIViewController {
    
    let alert = UIAlertController(title: "Hello!", message: "Have a nice day ;)", preferredStyle: .alert)
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Press the button", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .yellow
        button.layer.cornerRadius = 14
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        constraints()
        setupAlert()
        addAlert()
    }
    
    func constraints() {
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupAlert() {
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            _ in
            print("OK")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {
            _ in
            print("cancel")
        }))
    }
    
    func addAlert() {
        button.addTarget(self, action: #selector(toAlert), for: .touchUpInside)
    }
    
    @objc func toAlert() {
        self.present(alert, animated: true, completion: nil)
    }
}
