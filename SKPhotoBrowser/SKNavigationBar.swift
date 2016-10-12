//
//  SKNavigationBar.swift
//  SKPhotoBrowser
//
//  Created by Григорий Уланов on 12.10.16.
//  Copyright © 2016 suzuki_keishi. All rights reserved.
//

import UIKit

class SKNavigationBar: UINavigationBar {

    var showFrame: CGRect!
    var hideFrame: CGRect!

    private static let toolBarHeight: CGFloat = 64.0

    fileprivate weak var browser: SKPhotoBrowser?

    convenience init(browser: SKPhotoBrowser) {
        self.init(frame: CGRect.zero)

        self.browser = browser

        isTranslucent = false
        tintColor = UIColor.white
        barTintColor = UIColor.black
        titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

        let navigationItem = UINavigationItem()
        pushItem(navigationItem, animated: false)
    }

    func updateNavigationBar(_ currentPageIndex: Int) {
        guard let browser = browser else { return }

        if browser.numberOfPhotos > 1 {
            self.topItem?.title = "\(currentPageIndex + 1) \(SKPhotoBrowserOptions.navigationBarCounterSepatator) \(browser.numberOfPhotos)"
        } else {
            self.topItem?.title = nil
        }
    }

    func setNewFrame(rect: CGRect) {
        self.frame = rect
        showFrame = rect

        hideFrame = CGRect(x: rect.origin.x, y: rect.origin.y - 20, width: rect.size.width, height: rect.size.height)
    }

    func updateFrame(_ parentSize: CGSize) {
        let newRect = CGRect(x: 0, y: 0, width: parentSize.width, height: SKNavigationBar.toolBarHeight)
        setNewFrame(rect: newRect)
    }

}
