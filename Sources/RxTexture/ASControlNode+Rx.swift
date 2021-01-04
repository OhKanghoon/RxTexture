//
//  ASControlNode+Rx.swift
//  RxTexture
//
//  Created by ohkanghoon on 21/11/2019.
//

import AsyncDisplayKit
import RxCocoa
import RxSwift

public extension Reactive where Base: ASControlNode {
  /// Bindable sink for `enabled` property.
  var isEnabled: Binder<Bool> {
    return Binder(self.base, scheduler: CurrentThreadScheduler.instance) { node, isEnabled in
      node.isEnabled = isEnabled
    }
  }

  /// Bindable sink for `selected` property.
  var isSelected: Binder<Bool> {
    return Binder(self.base, scheduler: CurrentThreadScheduler.instance) { node, isSelected in
      node.isSelected = isSelected
    }
  }

  /// Bindable sink for `highlighted` property.
  var isHighlighted: ControlProperty<Bool> {
    return self.controlProperty(
      editingEvents: [.touchDown, .touchUpInside, .touchCancel],
      getter: { control in
        control.isHighlighted
      },
      setter: { control, isHighlighted in
        control.isHighlighted = isHighlighted
      }
    )
  }

  /// Reactive wrapper for target action pattern.
  ///
  /// - parameter controlEvents: Filter for observed ASControlNodeEvent types.
  func controlEvent(_ controlEvents: ASControlNodeEvent) -> ControlEvent<()> {
    let source: Observable<Void> = Observable.create { [weak control = self.base] observer in
      MainScheduler.ensureRunningOnMainThread()

      guard let control = control else {
        observer.on(.completed)
        return Disposables.create()
      }

      let controlTarget = ASControlTarget(control, controlEvents) { _ in
        observer.on(.next(()))
      }

      return Disposables.create(with: controlTarget.dispose)
    }
    .take(until: self.deallocated)

    return ControlEvent(events: source)
  }

  /// Creates a `ControlProperty` that is triggered by target/action pattern value updates.
  ///
  /// - parameter controlEvents: ASControlNodeEvents that trigger value update sequence elements.
  /// - parameter getter: Property value getter.
  /// - parameter setter: Property value setter.
  func controlProperty<T>(
    editingEvents: ASControlNodeEvent,
    getter: @escaping (Base) -> T,
    setter: @escaping (Base, T) -> ()
  ) -> ControlProperty<T> {
    let source: Observable<T> = Observable.create { [weak weakControl = base] observer in
      guard let control = weakControl else {
        observer.on(.completed)
        return Disposables.create()
      }

      observer.on(.next(getter(control)))

      let controlTarget = ASControlTarget(control, editingEvents) { _ in
        if let control = weakControl {
          observer.on(.next(getter(control)))
        }
      }

      return Disposables.create(with: controlTarget.dispose)
    }
    .take(until: self.deallocated)

    let bindingObserver = Binder(base, binding: setter)

    return ControlProperty<T>(values: source, valueSink: bindingObserver)
  }

  /// Reactive wrapper for `TouchUpInside` control event.
  var tap: ControlEvent<Void> {
    let source = self.controlEvent(.touchUpInside).map { _ in return }
    return ControlEvent(events: source)
  }
}
