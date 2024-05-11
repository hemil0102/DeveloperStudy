import Foundation

enum NetworkError: Error {
    case urlError
    case canNotParseData
}

public class APICaller {
    
    static func getTrendingMovies(
        completionHandler: @escaping (_ result: Result<TredingMoviesModel, NetworkError>) -> Void
    ) {
        
        let urlString = NetworkConstant.shared.serverAddress + "trending/all/day?api_key=" + NetworkConstant.shared.apikey
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            
            if error == nil,
               let data = dataResponse,
               let resultData = try? 
                JSONDecoder().decode(TredingMoviesModel.self, from: data) {
                completionHandler(.success(resultData))
            } else {
                completionHandler(.failure(.canNotParseData))
            }
            
        }.resume()
    }
}
