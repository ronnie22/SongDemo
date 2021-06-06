//
//  ViewController.swift
//  SongDemo


import UIKit



class ViewController: UIViewController{
    
    
    var results = [Result]()
    var manager = SongManager()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var songCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        songCollectionView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        manager.delegate = self
    }
}

//MARK: - CollectionView DataSource Methods


extension ViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.songNameLabel.text = results[indexPath.row].trackName
        cell.songImageView.imageFrom(url: URL(string: results[indexPath.row].artworkUrl100)!)
        
        return cell
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let name = searchBar.text {
            manager.fetchSong(with: name)
        }
        
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: Int = Int((collectionView.frame.width / 2) - 10)
        return CGSize(width: width , height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}


extension ViewController: SongMnagerDelegate {
    func didupdateSong(_ decodedData: SongModel) {
        DispatchQueue.main.async {
            self.results = decodedData.results
            self.songCollectionView.reloadData()
        }
    }
    
}



