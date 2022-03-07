//
//  ShowTableViewCell.swift
//  Midterm
//
//  Created by Devon Divinecz on 2022-03-07.
//

import UIKit

class ShowTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var collectionTitleLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var showImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
