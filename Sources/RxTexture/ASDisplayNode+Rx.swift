//
//  ASDisplayNode+Rx.swift
//  RxTexture
//
//  Created by KanghoonOh on 21/11/2019.
//

import AsyncDisplayKit
import RxCocoa
import RxSwift

public extension Reactive where Base: ASDisplayNode {
  var didEnterVisibleState: ControlEvent<Void> {
    let source =  self.methodInvoked(#selector(Base.didEnterVisibleState)).map { _ in return }
    return ControlEvent(events: source)
  }

  var didExitVisibleState: ControlEvent<Void> {
    let source =  self.methodInvoked(#selector(Base.didExitVisibleState)).map { _ in return }
    return ControlEvent(events: source)
  }

  var didEnterDisplayState: ControlEvent<Void> {
    let source =  self.methodInvoked(#selector(Base.didEnterDisplayState)).map { _ in return }
    return ControlEvent(events: source)
  }

  var didExitDisplayState: ControlEvent<Void> {
    let source =  self.methodInvoked(#selector(Base.didExitDisplayState)).map { _ in return }
    return ControlEvent(events: source)
  }
  
  var didEnterPreloadState: ControlEvent<Void> {
    let source =  self.methodInvoked(#selector(Base.didEnterPreloadState)).map { _ in return }
    return ControlEvent(events: source)
  }

  var didExitPreloadState: ControlEvent<Void> {
    let source =  self.methodInvoked(#selector(Base.didExitPreloadState)).map { _ in return }
    return ControlEvent(events: source)
  }

  var didLoad: ControlEvent<Void> {
    let source = self.methodInvoked(#selector(Base.didLoad)).map { _ in return }
    return ControlEvent(events: source)
  }
}

public extension Reactive where Base: ASDisplayNode {
  /// Bindable sink for `hidden` property.
  var isHidden: Binder<Bool> {
    return Binder(self.base, scheduler: CurrentThreadScheduler.instance) { node, hidden in
      node.isHidden = hidden
    }
  }

  /// Bindable sink for `alpha` property.
  var alpha: Binder<CGFloat> {
    return Binder(self.base, scheduler: CurrentThreadScheduler.instance) { node, alpha in
      node.alpha = alpha
    }
  }

  /// Bindable sink for `backgroundColor` property.
  var backgroundColor: Binder<UIColor?> {
    return Binder(self.base, scheduler: CurrentThreadScheduler.instance) { node, color in
      node.backgroundColor = color
    }
  }
}

public extension Reactive where Base: ASDisplayNode {
  var setNeedsLayout: Binder<Void> {
    return Binder(self.base, scheduler: CurrentThreadScheduler.instance) { node, _ in
      node.setNeedsLayout()
    }
  }
}
