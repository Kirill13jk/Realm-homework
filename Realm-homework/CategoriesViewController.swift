import UIKit
import RealmSwift

class CategoriesViewController: UITableViewController {
    
    var categories: Results<QuoteCategory>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Категории"
        
        let realm = try! Realm()
        categories = realm.objects(QuoteCategory.self)  // Извлекаем все категории из базы данных
        
        tableView.reloadData()  // Обновляем таблицу для отображения категорий
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
    
    // Переход на экран цитат выбранной категории
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        let quotesVC = QuotesByCategoryViewController(category: category.name)
        navigationController?.pushViewController(quotesVC, animated: true)
    }
}
