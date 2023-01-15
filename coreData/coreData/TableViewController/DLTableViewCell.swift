//
//  DLTableViewCell.swift
//  coreData
//
//  Created by Sawan Rana on 15/01/23.
//

import UIKit

class DLTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dlLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(name: String, dl: String) {
        nameLabel.text = name
        dlLabel.text = dl
    }

}
