//
//  NetworkService.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/9/20.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    private let urlSession = URLSession.shared
    private let baseUrlStr = "https://api.openweathermap.org/data/2.5/weather"
    private let appId = "2cffdee639d5d1519c535e82fb04370f"
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    enum NetworkServiceError: Error {
        case apiError
        case noData
        case invalidEndpoint
        case invalidResponse
        case decodeError
    }
    
    private func fetchData<T: Decodable>(url: URL?, lat: Double, lon: Double, completion: @escaping (Result<T, NetworkServiceError>) -> Void) {

        guard let urlObj = url, var urlComponents = URLComponents(url: urlObj, resolvingAgainstBaseURL: true) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        let queryItems = [URLQueryItem(name: "lat", value: String(lat)), URLQueryItem(name: "lon", value: String(lon)), URLQueryItem(name: "appid", value: appId)]
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: url) { result in
            
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }

                do {
                    let values = try self.jsonDecoder.decode(T.self, from: data)
                    completion(.success(values))
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(.failure(.apiError))
            }
        }.resume()
    }
    
    func fetchWeather(from latitude: Double, longitude: Double, result: @escaping (Result<WeatherResponse, NetworkServiceError>) -> Void) {
        let urlString = "\(baseUrlStr)?lat=\(latitude)&lon=\(longitude)&appid=\(appId)"
        let weatherUrl = URL(string: urlString)
        fetchData(url: weatherUrl, lat: latitude, lon: longitude, completion: result)
    }
}
