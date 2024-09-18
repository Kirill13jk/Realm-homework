import UIKit
import RealmSwift

class RandomQuoteViewController: UIViewController {
    
    let quoteLabel = UILabel()
    let loadButton = UIButton(type: .system)
    let apiService = APIService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        quoteLabel.textAlignment = .center
        quoteLabel.numberOfLines = 0
        
        loadButton.setTitle("Загрузить цитату", for: .normal)
        loadButton.addTarget(self, action: #selector(loadQuote), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [quoteLabel, loadButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func loadQuote() {
        apiService.fetchRandomQuote { [weak self] quote in
            guard let self = self, let quote = quote else { return }
            
            // Сохраняем цитату в зашифрованный Realm
            self.saveQuote(quote)
            
            DispatchQueue.main.async {
                self.quoteLabel.text = quote.text
            }
        }
    }
    
    // Добавляем метод для сохранения цитаты и категории в Realm
    private func saveQuote(_ quote: ChuckNorrisQuote) {
        if let realm = RealmManager.shared.realm() {
            // Проверка на дубликаты по идентификатору цитаты
            if realm.object(ofType: ChuckNorrisQuote.self, forPrimaryKey: quote.id) == nil {
                try! realm.write {
                    realm.add(quote)
                    
                    // Сохранение категории, если она указана
                    if let categoryName = quote.category, !categoryName.isEmpty {
                        // Проверка на дубликаты категорий
                        if realm.object(ofType: QuoteCategory.self, forPrimaryKey: categoryName) == nil {
                            let category = QuoteCategory()
                            category.name = categoryName
                            realm.add(category)
                        }
                    }
                }
            }
        } else {
            print("Не удалось открыть зашифрованную базу данных")
        }
    }
}
