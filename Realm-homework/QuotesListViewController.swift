import UIKit
import RealmSwift

class QuotesListViewController: UITableViewController {
    
    var quotes: Results<ChuckNorrisQuote>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Все цитаты"
        
        // Получаем экземпляр Realm через RealmManager
        guard let realm = RealmManager.shared.realm() else {
            print("Ошибка при открытии Realm")
            return
        }
        
        // Сортировка по полю createdAt
        quotes = realm.objects(ChuckNorrisQuote.self).sorted(byKeyPath: "createdAt", ascending: false)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = quotes?.count ?? 0
        print("Количество строк в разделе: \(count)")
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        guard let quote = quotes?[indexPath.row] else {
            cell.textLabel?.text = "Нет данных"
            return cell
        }
        cell.textLabel?.text = quote.text
        cell.detailTextLabel?.text = "Категория: \(quote.category ?? "Без категории")"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedQuote = quotes?[indexPath.row] else { return }
        let detailVC = QuoteDetailViewController()
        detailVC.quoteText = selectedQuote.text
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
