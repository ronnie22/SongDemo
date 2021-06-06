//
//  SongManager.swift
//  SongDemo


import Foundation
import UIKit


protocol SongMnagerDelegate {
    func didupdateSong(_ decodedData: SongModel)
}

struct SongManager {
    
    let SongUrl = "https://itunes.apple.com/search?term="
    
    var delegate:  SongMnagerDelegate?
    
    func fetchSong(with artistName: String){
        let names = artistName.components(separatedBy: " ")
        var urlString = SongUrl
        for i in names {
            urlString = i == names[0] ? urlString + i : urlString + "+" + i
        }
        urlString = urlString + "&entity=song"
        performTask(urlString: urlString)
    }
    
    func performTask(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("data not found")
                    return
                }
                if let safeData = data {
                    if let songs = self.parseJson(songData: safeData) {
                        delegate?.didupdateSong(songs)
                    }else {
                        print("decoded Data not back")
                    }
                }else {
                    print("safeData error")
                }
            }.resume()
        }else{
            print("not done")
        }
    }
    
    func parseJson(songData: Data) -> SongModel? {
        do {
            let decodedResponse = try JSONDecoder().decode(SongModel.self, from: songData)
            return decodedResponse
        }catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
