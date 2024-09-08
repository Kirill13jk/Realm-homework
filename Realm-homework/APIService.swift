import Alamofire
import RealmSwift

// Модель для парсинга JSON ответа от API
struct ChuckNorrisQuoteResponse: Decodable {
    let id: String
    let value: String
    let categories: [String]?
}

class APIService {
    
    func fetchRandomQuote(completion: @escaping (ChuckNorrisQuote?) -> Void) {
        let url = "https://api.chucknorris.io/jokes/random"
        
        // Используем Alamofire для получения случайной цитаты
        AF.request(url).responseDecodable(of: ChuckNorrisQuoteResponse.self) { response in
            switch response.result {
            case .success(let quoteResponse):
                // Создаём объект ChuckNorrisQuote для хранения в Realm
                let quote = ChuckNorrisQuote()
                quote.id = quoteResponse.id
                quote.text = quoteResponse.value
                quote.category = quoteResponse.categories?.first
                completion(quote)
            case .failure(let error):
                print("Error: \(error)")
                completion(nil)
            }
        }
    }
}
