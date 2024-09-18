import UIKit
import RealmSwift

class CategoriesViewController: UITableViewController {
    
    var categories: Results<QuoteCategory>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Категории"
        
        // Получаем экземпляр Realm через RealmManager
        guard let realm = RealmManager.shared.realm() else {
            print("Ошибка при открытии Realm")
            return
        }
        
        // Загружаем категории из базы данных
        categories = realm.objects(QuoteCategory.self)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = categories?.count ?? 0
        print("Количество строк в разделе: \(count)")
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        guard let category = categories?[indexPath.row] else {
            cell.textLabel?.text = "Нет данных"
            return cell
        }
        cell.textLabel?.text = category.name
        return cell
    }
    
    // Переход на экран цитат выбранной категории
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let category = categories?[indexPath.row] else { return }
        let quotesVC = QuotesByCategoryViewController(category: category.name)
        navigationController?.pushViewController(quotesVC, animated: true)
    }
}
