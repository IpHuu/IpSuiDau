//
//  ButtonExtension.swift
//  IpSuiDau
//
//  Created by Ipman on 08/05/2024.
//

import Foundation
import UIKit
extension UIButton {

    func centerImageAndButton(_ gap: CGFloat, imageOnTop: Bool) {

      guard let imageView = self.currentImage,
      let titleLabel = self.titleLabel?.text else { return }

      let sign: CGFloat = imageOnTop ? 1 : -1
        self.titleEdgeInsets = UIEdgeInsets(top: (imageView.size.height + gap) * sign, left: -imageView.size.width, bottom: 0, right: 0);

        let titleSize = titleLabel.size(withAttributes:[NSAttributedString.Key.font: self.titleLabel!.font!])
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + gap) * sign, left: 0, bottom: 0, right: -titleSize.width)
    }
}
