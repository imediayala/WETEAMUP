//
//  belowHeaderStickyCollectionReusableView.swift
//  WeTeamUp
//
//  Created by Daniel Ayala on 18/08/2017.
//  Copyright © 2017 Daniel Ayala. All rights reserved.
//

import UIKit

protocol PostButtonDelegate : class {
    func collectionViewCellDidTapPost(_ sender: belowHeaderStickyCollectionReusableView)
}

class belowHeaderStickyCollectionReusableView: UICollectionReusableView {
    @IBOutlet var searchBarHome: UISearchBar!
 
    @IBOutlet var searchHomeView: UIView!
    weak var delegate: PostButtonDelegate?
    
    @IBAction func postActionButton(_ sender: Any) {
        print("class custom reusableView button tapped")
        delegate?.collectionViewCellDidTapPost(self)

    }
}
