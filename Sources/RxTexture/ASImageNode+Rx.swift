//
//  ASImageNode+Rx.swift
//  RxTexture
//
//  Created by ohkanghoon on 12/01/2020.
//

import AsyncDisplayKit
import RxCocoa
import RxSwift

public extension Reactive where Base: ASImageNode {
  var image: Binder<UIImage?> {
    return Binder(self.base, scheduler: CurrentThreadScheduler.instance) { node, image in
      node.image = image
    }
  }
}
