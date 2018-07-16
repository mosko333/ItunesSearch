//
//  AlbumTableViewCell.swift
//  ItunesSearch
//
//  Created by Adam on 01/06/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    var album: Album? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var songCountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var albumImage: UIImageView!

    func updateViews() {
        guard let album = album else { return }
        if let collectionName = album.collectionName {
        albumNameLabel.text = collectionName
        } else { albumNameLabel.text = "" }
        if let artistName = album.artistName {
        artistNameLabel.text = artistName
        } else { artistNameLabel.text = ""}
        if let genre = album.primaryGenreName {
        genreLabel.text = genre
        } else { genreLabel.text = "" }
        if let trackCount = album.trackCount {
        songCountLabel.text = "Songs: \(trackCount)"
        } else { songCountLabel.text = "Songs: N/A" }
        if let price = album.trackPrice {
        priceLabel.text = "$ \(price)"
        } else { priceLabel.text = "" }

        guard let artworkUrlString = album.artWorkUrlString else { return }
        AlbumController.fetchImageWith(artWorkUrlString: artworkUrlString ) { (image) in
            let fetchedImage = image
            DispatchQueue.main.async {
                self.albumImage.image = fetchedImage
            }
        }
    }
}
