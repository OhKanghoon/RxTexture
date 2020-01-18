//
//  ASButtonNode+RxTests.swift
//  RxTextureTests
//
//  Created by KanghoonOh on 17/01/2020.
//

import XCTest

import AsyncDisplayKit
import RxSwift
import RxTexture

final class ASButtonNodeTests: XCTestCase {
  func testAttributedTitleNormal() {
    let node = ASButtonNode()

    XCTAssertFalse(node.attributedTitle(for: []) == NSAttributedString(string: "normal"))
    _ = Observable.just(NSAttributedString(string: "normal")).subscribe(node.rx.attributedTitle(for: []))
    XCTAssertTrue(node.attributedTitle(for: []) == NSAttributedString(string: "normal"))
  }

  func testAttributedTitleSelected() {
    let node = ASButtonNode()

    XCTAssertFalse(node.attributedTitle(for: .selected) == NSAttributedString(string: "normal"))
    _ = Observable.just(NSAttributedString(string: "normal")).subscribe(node.rx.attributedTitle(for: .selected))
    XCTAssertTrue(node.attributedTitle(for: .selected) == NSAttributedString(string: "normal"))
  }

  func testAttributedTitleDefault() {
    let node = ASButtonNode()

    XCTAssertFalse(node.attributedTitle(for: []) == NSAttributedString(string: "normal"))
    _ = Observable.just(NSAttributedString(string: "normal")).subscribe(node.rx.attributedTitle())
    XCTAssertTrue(node.attributedTitle(for: []) == NSAttributedString(string: "normal"))
  }

  func testImageNormal() {
    let node = ASButtonNode()
    let image = UIImage()
    
    XCTAssertFalse(node.image(for: .normal) == image)
    _ = Observable.just(image).subscribe(node.rx.image(for: .normal))
    XCTAssertTrue(node.image(for: .normal) == image)
  }

  func testImageSelected() {
    let node = ASButtonNode()
    let image = UIImage()

    XCTAssertFalse(node.image(for: .selected) == image)
    _ = Observable.just(image).subscribe(node.rx.image(for: .selected))
    XCTAssertTrue(node.image(for: .selected) == image)
  }

  func testImageDefault() {
    let node = ASButtonNode()
    let image = UIImage()

    XCTAssertFalse(node.image(for: []) == image)
    _ = Observable.just(image).subscribe(node.rx.image())
    XCTAssertTrue(node.image(for: []) == image)
  }

  func testBackgroundImageNormal() {
    let node = ASButtonNode()
    let image = UIImage()

    XCTAssertFalse(node.backgroundImage(for: .normal) == image)
    _ = Observable.just(image).subscribe(node.rx.backgroundImage(for: .normal))
    XCTAssertTrue(node.backgroundImage(for: .normal) == image)
  }

  func testBackgroundImageSelected() {
    let node = ASButtonNode()
    let image = UIImage()

    XCTAssertFalse(node.backgroundImage(for: .selected) == image)
    _ = Observable.just(image).subscribe(node.rx.backgroundImage(for: .selected))
    XCTAssertTrue(node.backgroundImage(for: .selected) == image)
  }

  func testBackgroundImageDefault() {
    let node = ASButtonNode()
    let image = UIImage()

    XCTAssertFalse(node.backgroundImage(for: []) == image)
    _ = Observable.just(image).subscribe(node.rx.backgroundImage())
    XCTAssertTrue(node.backgroundImage(for: []) == image)
  }
}
