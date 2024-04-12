
import Foundation

//MARK: -------- Class --------

public class NetworkManager {
    
    //MARK: -------- Variables --------
    
    public static let shared = NetworkManager()
    private let session = URLSession(configuration: .default)
    
    public init() {}
    
    //MARK: -------- Custom Functions --------
    
    public func request<T: Decodable>(_ url: URL, method: HTTPMethod, body: Data? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        
        // Setting up URL Request
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let body = body, method == .post {
            request.httpBody = body
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                
                // Error Handling
                guard let data = data, error == nil else {
                    completion(.failure(error ?? NSError(domain: "NetworkError", code: 0, userInfo: nil)))
                    return
                }
                
                // Handling of data response and decoding to JSON
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
                
            }
        }.resume()
    }
    
}

