//
//  ASTextNode+Rx.swift
//  RxTexture
//
//  Created by ohkanghoon on 12/01/2020.
//

import AsyncDisplayKit
import RxCocoa
import RxSwift

public extension Reactive where Base: ASTextNode {
  var attributedText: Binder<NSAttributedString?> {
    return Binder(self.base, scheduler: CurrentThreadScheduler.instance) { node, attributedText in
      node.attributedText = attributedText
    }
  }
}
