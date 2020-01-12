//
//  UIScrollView+loadMore.swift
//  RecipeSearch
//
//  Created by Atef on 1/12/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    func  isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        return self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
}
