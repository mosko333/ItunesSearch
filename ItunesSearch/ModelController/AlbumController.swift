//
//  AlbumController.swift
//  ItunesSearch
//
//  Created by Adam on 01/06/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class AlbumController {
    struct Constants {
        static let baseURL = URL(string: "https://itunes.apple.com/")
    }

    static func fetchAlbumWith(searchTerm: String, completion: @escaping (([Album]?) -> Void)) {
        //URL
        guard var url = Constants.baseURL else { completion(nil) ; return }
        url.appendPathComponent("search", isDirectory: true)
        //Query
        let urlParamaters = [ "media": "music",
                             "term": searchTerm]
        var componets = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let queryItems = urlParamaters.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        componets?.queryItems = queryItems
        guard let finalUrl = componets?.url else {
            print("❌ Error creating complete url")
            completion(nil) ; return }
        print("📡\(finalUrl.absoluteString)📡")

        //DataTaks
        URLSession.shared.dataTask(with: finalUrl) { (data, _, error) in
            if let error = error {
                print("❌ Error downloading Album with DataTask \(error.localizedDescription)")
                completion(nil) ; return }
            guard let data = data else { completion(nil) ; return }
            do {
                let jsonDecoder = JSONDecoder()
                let topLevelData = try jsonDecoder.decode(TopLevelData.self, from: data)
                let albums = topLevelData.results
                completion(albums) ; return
            } catch DecodingError.keyNotFound(let codingKey, let context) {
                print("❌Error: Coding key not found: \(codingKey) in \(context)")
                completion(nil) ; return
            } catch {
                print("❌ Error decoding fetched Album: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }

    static func fetchImageWith(artWorkUrlString: String, completion: @escaping ((UIImage) -> Void)) {
        //URL
        guard let url = URL(string: artWorkUrlString) else { completion(#imageLiteral(resourceName: "noArt")) ; return }
        print("📡\(url.absoluteString)📡")

        //DataTask
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("❌ Error downloading image with DataTask \(error.localizedDescription)")
                completion(#imageLiteral(resourceName: "noArt")) ; return }
            guard let data = data,
                let image = UIImage(data: data) else { completion(#imageLiteral(resourceName: "noArt")) ; return }
            completion(image)
        }.resume()
    }

}
