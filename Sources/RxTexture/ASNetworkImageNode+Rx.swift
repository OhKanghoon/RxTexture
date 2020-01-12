//
//  ASNetworkImageNode+Rx.swift
//  RxTexture
//
//  Created by ohkanghoon on 12/01/2020.
//

import AsyncDisplayKit
import RxCocoa
import RxSwift

public extension Reactive where Base: ASNetworkImageNode {
  var url: Binder<URL?> {
    return Binder(self.base, scheduler: CurrentThreadScheduler.instance) { node, url in
      node.url = url
    }
  }

  func url(resetToDefault: Bool) -> Binder<URL?> {
    return Binder(self.base, scheduler: CurrentThreadScheduler.instance) { node, url in
      node.setURL(url, resetToDefault: resetToDefault)
    }
  }
}
