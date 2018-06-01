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
//https://itunes.apple.com/search?media=music&term=abba

    static func fetchAlbumWith(searchTerm: String, completion: @escaping (([Album]?) -> Void)) {
        //URL
        guard var url = Constants.baseURL else { completion(nil) ; return }
        url.appendPathComponent("search", isDirectory: true)
        //Query
        let urlParamaters = [ "media" : "music",
                             "term" : searchTerm]
        var componets = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let queryItems = urlParamaters.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        componets?.queryItems = queryItems
        guard let finalUrl = componets?.url else {
            print("❌ Error creating complete url")
            completion(nil) ; return }
        print("📡\(finalUrl.absoluteString)📡")
    }

}
