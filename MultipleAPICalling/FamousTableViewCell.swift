//
//  FamousTableViewCell.swift
//  MultipleAPICalling
//
//  Created by Arpit iOS Dev. on 12/06/24.
//

import UIKit

class FamousTableViewCell: UITableViewCell {
    
    @IBOutlet weak var quoteLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
