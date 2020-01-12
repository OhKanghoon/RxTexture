//
//  ASNetworkImageNode+RxTests.swift
//  RxTextureTests
//
//  Created by ohkanghoon on 12/01/2020.
//

import XCTest

import AsyncDisplayKit
import RxSwift
import RxTexture

final class ASNetworkImageNodeTests: XCTestCase {
  func testASNetworkImageNode_urlObserver() {
    let node = ASNetworkImageNode()
    XCTAssertEqual(node.url, nil)
    let url = URL(string: "test.com")
    _ = Observable.just(url).bind(to: node.rx.url)

    XCTAssertEqual(node.url, url)
  }
}
