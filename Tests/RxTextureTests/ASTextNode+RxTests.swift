//
//  ASTextNode+RxTests.swift
//  RxTextureTests
//
//  Created by ohkanghoon on 12/01/2020.
//

import XCTest

import AsyncDisplayKit
import RxSwift
import RxTexture

final class ASTextNodeTests: XCTestCase {
  func testASTextNode_attributedTextObserver() {
    let node = ASTextNode()
    XCTAssertEqual(node.attributedText, nil)
    let text = NSAttributedString(string: "Hello!")
    _ = Observable.just(text).bind(to: node.rx.attributedText)
    
    XCTAssertEqual(node.attributedText, text)
  }
}
