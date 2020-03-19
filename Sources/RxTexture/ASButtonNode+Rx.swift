//
//  ASButtonNode+Rx.swift
//  RxTexture
//
//  Created by KanghoonOh on 17/01/2020.
//

import AsyncDisplayKit
import RxCocoa
import RxSwift

public extension Reactive where Base: ASButtonNode {
  /// Reactive wrapper for `setAttributedTitle(_:for:)`
  func attributedTitle(for controlState: UIControl.State = []) -> Binder<NSAttributedString?> {
    return Binder(self.base, scheduler: CurrentThreadScheduler.instance) { node, attributedTitle in
      node.setAttributedTitle(attributedTitle, for: controlState)
    }
  }

  /// Reactive wrapper for `setImage(_:for:)`
  func image(for controlState: UIControl.State = []) -> Binder<UIImage?> {
    return Binder(self.base, scheduler: CurrentThreadScheduler.instance) { node, image -> Void in
      node.setImage(image, for: controlState)
    }
  }

  /// Reactive wrapper for `setBackgroundImage(_:for:)`
  func backgroundImage(for controlState: UIControl.State = []) -> Binder<UIImage?> {
    return Binder(self.base, scheduler: CurrentThreadScheduler.instance) { node, image -> Void in
      node.setBackgroundImage(image, for: controlState)
    }
  }
}
