//
//  SongModel.swift
//  SongDemo


import Foundation


struct SongModel: Codable {
    let results: [Result]
}

struct Result: Codable {
    let trackName: String
    let artworkUrl100: String
}
