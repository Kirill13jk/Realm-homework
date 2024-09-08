import UIKit
import RealmSwift

class QuotesByCategoryViewController: UITableViewController {
    
    var quotes: Results<ChuckNorrisQuote>!
    
    init(category: String) {
        super.init(style: .plain)
        let realm = try! Realm()
        // Фильтруем цитаты по выбранной категории
        quotes = realm.objects(ChuckNorrisQuote.self).filter("category == %@", category)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Цитаты категории"
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let quote = quotes[indexPath.row]
        cell.textLabel?.text = quote.text
        cell.detailTextLabel?.text = "Категория: \(quote.category ?? "Без категории")"
        return cell
    }
    
    // Обрабатываем нажатие на цитату и открываем экран с её полным текстом
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedQuote = quotes[indexPath.row]
        let detailVC = QuoteDetailViewController()
        detailVC.quoteText = selectedQuote.text  // Передаём полный текст цитаты в контроллер
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
