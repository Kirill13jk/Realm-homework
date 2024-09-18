import UIKit

class QuoteDetailViewController: UIViewController {
    
    var quoteText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let quoteLabel = UILabel()
        quoteLabel.numberOfLines = 0
        quoteLabel.textAlignment = .center
        quoteLabel.text = quoteText
        
        quoteLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quoteLabel)
        
        NSLayoutConstraint.activate([
            quoteLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            quoteLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            quoteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            quoteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
