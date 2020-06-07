//
//  UserFollows.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/6/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

class UserFollowsView: UIView {
    
    var user: User? {
        didSet {
            // Set user follows
            flwersLabel.text = "\(user?.followers ?? 0)"
            flwingsLabel.text = "\(user?.following ?? 0)"
        }
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    //MARK: IBOutlets
    @IBOutlet weak var flwersLabel: UILabel!
    @IBOutlet weak var flwingsLabel: UILabel!
    
    func commonInit() {
        let bundle = Bundle.init(for: UserFollowsView.self)
        if let viewsToAdd = bundle.loadNibNamed("UserFollows", owner: self, options: nil),
            let contentView = viewsToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight,
                                            .flexibleWidth]
        }
    }
}
