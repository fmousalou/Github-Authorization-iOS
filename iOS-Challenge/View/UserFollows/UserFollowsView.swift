//
//  UserFollows.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/6/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

class UserFollowsView: UIView {
    
    //MARK: Init
    init(followers: Int?, following: Int?) {
        super.init(frame: .zero)
        commonInit()
        flwersLabel.text = "\(followers ?? 0)"
        flwingsLabel.text = "\(following ?? 0)"
    }
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
