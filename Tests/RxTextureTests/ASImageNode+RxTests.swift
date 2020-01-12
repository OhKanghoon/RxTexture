//
//  ASImageNode+RxTests.swift
//  RxTextureTests
//
//  Created by ohkanghoon on 12/01/2020.
//

import XCTest

import AsyncDisplayKit
import RxExpect
import RxSwift
import RxTexture

final class ASImageNodeTests: XCTestCase {
  func testASImageNode_imageObserver() {
    let node = ASImageNode()
    XCTAssertEqual(node.image, nil)
    let image = UIImage(named: "hi")
    _ = Observable.just(image).bind(to: node.rx.image)

    XCTAssertEqual(node.image, image)
  }
}
