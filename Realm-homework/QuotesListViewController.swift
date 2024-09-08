import UIKit
import RealmSwift

class QuotesListViewController: UITableViewController {
    
    var quotes: Results<ChuckNorrisQuote>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Все цитаты"
        
        let realm = try! Realm()
        // Сортировка по полю createdAt
        quotes = realm.objects(ChuckNorrisQuote.self).sorted(byKeyPath: "createdAt", ascending: false)
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedQuote = quotes[indexPath.row]
        let detailVC = QuoteDetailViewController()
        detailVC.quoteText = selectedQuote.text
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
