//
//  CollectionViewCell.swift
//  SongDemo
//


import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var songImageView: UIImageView!
    
    @IBOutlet weak var songNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
