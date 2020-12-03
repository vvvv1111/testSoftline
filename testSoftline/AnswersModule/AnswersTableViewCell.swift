//
//  AnswersTableViewCell.swift
//  testSoftline
//
//  Created by Vladimir on 02.12.2020.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import UIKit

class AnswersTableViewCell: UITableViewCell {
    @IBOutlet weak var numberOfVotes: UILabel!
    @IBOutlet weak var answerBody: UILabel!
    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var answeredDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
