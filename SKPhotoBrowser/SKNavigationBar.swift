//
//  SKNavigationBar.swift
//  SKPhotoBrowser
//
//  Created by Григорий Уланов on 12.10.16.
//  Copyright © 2016 suzuki_keishi. All rights reserved.
//

import UIKit

class SKNavigationBar: UIView {

    var showFrame: CGRect!
    var hideFrame: CGRect!

    private static let toolBarHeight: CGFloat = 44.0

    fileprivate weak var browser: SKPhotoBrowser?

    private var countLabel: UILabel?
    private var doneButton: UIButton?

    var onDoneTap: (() -> Void)?
    var isStatusBarHidden: Bool = false {
        didSet {
            if let bounds = superview?.bounds {
                updateFrame(bounds.size)
            }
        }
    }

    private var isBigStatusBar: Bool {
        return statusBarHeight > 20 ? true : false
    }

    private var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }

    convenience init(browser: SKPhotoBrowser) {
        self.init(frame: CGRect.zero)

        self.browser = browser

        backgroundColor = UIColor.black.withAlphaComponent(0.65)

        countLabel = UILabel()
        countLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        countLabel?.textColor = UIColor.white
        countLabel?.textAlignment = .center
        if let countLabel = countLabel {
            addSubview(countLabel)
        }

        doneButton = UIButton()
        doneButton?.setTitle(SKPhotoBrowserOptions.navigationBarDoneTitle, for: .normal)
        doneButton?.setTitleColor(UIColor.white, for: .normal)
        doneButton?.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        if let doneButton = doneButton {
            addSubview(doneButton)
        }
    }

    @objc private func doneButtonAction() {
        onDoneTap?()
    }

    func updateNavigationBar(_ currentPageIndex: Int) {
        guard let browser = browser else { return }

        if browser.numberOfPhotos > 1 {
            self.countLabel?.text = "\(currentPageIndex + 1) \(SKPhotoBrowserOptions.navigationBarCounterSepatator) \(browser.numberOfPhotos)"
        } else {
            self.countLabel?.text = nil
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isStatusBarHidden {
            countLabel?.frame = CGRect(x: 0,
                                       y: isBigStatusBar ? 0 : statusBarHeight,
                                       width: bounds.width,
                                       height: isBigStatusBar ? bounds.height : bounds.height - statusBarHeight)
            doneButton?.frame = CGRect(x: 0,
                                       y: isBigStatusBar ? 0 : statusBarHeight,
                                       width: 85,
                                       height: isBigStatusBar ? bounds.height : bounds.height - statusBarHeight)
        } else {
            countLabel?.frame = bounds
            doneButton?.frame = CGRect(x: 0, y: 0, width: 85, height: bounds.height)
        }
    }

    private func setNewFrame(rect: CGRect) {
        frame = rect
        showFrame = rect
        hideFrame = CGRect(x: rect.origin.x, y: rect.origin.y - 20, width: rect.size.width, height: rect.size.height)
        layoutSubviews()
    }

    func updateFrame(_ parentSize: CGSize) {
        var newRect: CGRect?

        if !isStatusBarHidden {
            newRect = CGRect(x: 0,
                             y: isBigStatusBar ? statusBarHeight/2 : 0,
                             width: parentSize.width,
                             height: isBigStatusBar ? SKNavigationBar.toolBarHeight : SKNavigationBar.toolBarHeight + statusBarHeight)
        } else {
            newRect = CGRect(x: 0, y: 0, width: parentSize.width, height: SKNavigationBar.toolBarHeight)
        }
        
        if let newRect = newRect {
            setNewFrame(rect: newRect)
        }
    }

}
