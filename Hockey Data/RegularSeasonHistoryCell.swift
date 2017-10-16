//
//  RegularSeasonHistoryCell.swift
//  HockeyData
//
//  Created by Alex King on 10/15/17.
//  Copyright © 2017 Alex King. All rights reserved.
//

import Foundation
import TinyConstraints

class RegularSeasonHistoryCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}

private extension RegularSeasonHistoryCell {
    
    var seasonLabel: UILabel {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    func setupViews() {
        addSubview(seasonLabel)
        seasonLabel.top(to: self, offset: 10)
        seasonLabel.left(to: self, offset: 10)
        seasonLabel.bottom(to: self, offset: 10)
        seasonLabel.right(to: self, offset: -10, relation: .equalOrLess)
    }
}
