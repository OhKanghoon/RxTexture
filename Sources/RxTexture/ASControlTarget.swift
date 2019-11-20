//
//  ASControlTarget.swift
//  RxTexture
//
//  Created by ohkanghoon on 20/11/2019.
//

import AsyncDisplayKit
import RxSwift

typealias Control = ASControlNode

final class ASControlTarget: ASRxTarget {
  typealias Callback = (Control) -> Void

  let selector = #selector(ASControlTarget.eventHandler(_:))

  weak var control: Control?
  let controlEvents: ASControlNodeEvent
  var callback: Callback?

  init(
    _ control: Control,
    _ controlEvents: ASControlNodeEvent,
    callback: @escaping Callback
  ) {
    self.control = control
    self.controlEvents = controlEvents
    self.callback = callback

    super.init()

    control.addTarget(self, action: selector, forControlEvents: controlEvents)

    let method = self.method(for: selector)
    if method == nil {
      fatalError("Can't find method")
    }
  }

  @objc func eventHandler(_ sender: UIGestureRecognizer) {
    if let callback = self.callback, let control = self.control {
      callback(control)
    }
  }

  override func dispose() {
    super.dispose()
    self.control?.removeTarget(self, action: selector, forControlEvents: self.controlEvents)
    self.callback = nil
  }
}
