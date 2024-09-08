import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let randomQuoteVC = UINavigationController(rootViewController: RandomQuoteViewController())
        randomQuoteVC.tabBarItem = UITabBarItem(title: "Цитата", image: UIImage(systemName: "quote.bubble"), tag: 0)
        
        let quotesListVC = UINavigationController(rootViewController: QuotesListViewController())
        quotesListVC.tabBarItem = UITabBarItem(title: "Цитаты", image: UIImage(systemName: "list.bullet"), tag: 1)
        
        let categoriesVC = UINavigationController(rootViewController: CategoriesViewController())
        categoriesVC.tabBarItem = UITabBarItem(title: "Категории", image: UIImage(systemName: "folder"), tag: 2)
        
        viewControllers = [randomQuoteVC, quotesListVC, categoriesVC]
    }
}
