//
//  ASRxTarget.swift
//  RxTexture
//
//  Created by KanghoonOh on 21/11/2019.
//

import class Foundation.NSObject

import RxSwift

class ASRxTarget: NSObject, Disposable {
  private var retainSelf: ASRxTarget?

  override init() {
    super.init()
    self.retainSelf = self

    #if TRACE_RESOURCES
    _ = Resources.incrementTotal()
    #endif
  }

  func dispose() {
    self.retainSelf = nil
  }

  #if TRACE_RESOURCES
  deinit {
    _ = Resources.decrementTotal()
  }
  #endif
}
