//
//  UITextView+Ext.swift
//  Counter
//
//  Created by MAKOVEY Vladislav on 25.07.2023.
//

import UIKit

extension UITextView {
    func scrollLogToLastElement() {
        guard !text.isEmpty else { return }
        let bottomLocation = self.text.count - 1
        self.scrollRangeToVisible(.init(location: bottomLocation, length: 1))
    }
}
