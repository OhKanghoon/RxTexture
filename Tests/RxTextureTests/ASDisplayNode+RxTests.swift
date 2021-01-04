//
//  ASDisplayNode+RxTests.swift
//  RxTextureTests
//
//  Created by KanghoonOh on 21/11/2019.
//

import XCTest

import AsyncDisplayKit
import RxSwift
import RxTest
import RxTexture

final class ASDisplayNodeTests: XCTestCase {
  func testDidEnterVisibleState() {
    let scheduler = TestScheduler(initialClock: 0)
    let node = ASDisplayNode()
    _ = node.view

    scheduler.scheduleAt(100) { node.didEnterVisibleState() }

    let response = scheduler.start(created: 0, subscribed: 0, disposed: 100) {
      node.rx.didEnterVisibleState
    }

    XCTAssertEqual(response.events.filter { (0..<100).contains($0.time) }.count, 0)
    XCTAssertEqual(response.events.filter { (100...).contains($0.time) }.count, 1)
  }

  func testDidExitVisibleState() {
    let scheduler = TestScheduler(initialClock: 0)
    let node = ASDisplayNode()
    _ = node.view

    scheduler.scheduleAt(100) { node.didExitVisibleState() }

    let response = scheduler.start(created: 0, subscribed: 0, disposed: 100) {
      node.rx.didExitVisibleState
    }

    XCTAssertEqual(response.events.filter { (0..<100).contains($0.time) }.count, 0)
    XCTAssertEqual(response.events.filter { (100...).contains($0.time) }.count, 1)
  }

  func testDidEnterDisplayState() {
    let scheduler = TestScheduler(initialClock: 0)
    let node = ASDisplayNode()
    _ = node.view

    scheduler.scheduleAt(100) { node.didEnterDisplayState() }

    let response = scheduler.start(created: 0, subscribed: 0, disposed: 100) {
      node.rx.didEnterDisplayState
    }

    XCTAssertEqual(response.events.filter { (0..<100).contains($0.time) }.count, 0)
    XCTAssertEqual(response.events.filter { (100...).contains($0.time) }.count, 1)
  }

  func testDidExitDisplayState() {
    let scheduler = TestScheduler(initialClock: 0)
    let node = ASDisplayNode()
    _ = node.view

    scheduler.scheduleAt(100) { node.didExitDisplayState() }

    let response = scheduler.start(created: 0, subscribed: 0, disposed: 100) {
      node.rx.didExitDisplayState
    }

    XCTAssertEqual(response.events.filter { (0..<100).contains($0.time) }.count, 0)
    XCTAssertEqual(response.events.filter { (100...).contains($0.time) }.count, 1)
  }

  func testDidEnterPreloadState() {
    let scheduler = TestScheduler(initialClock: 0)
    let node = ASDisplayNode()
    _ = node.view

    scheduler.scheduleAt(100) { node.didEnterPreloadState() }

    let response = scheduler.start(created: 0, subscribed: 0, disposed: 100) {
      node.rx.didEnterPreloadState
    }

    XCTAssertEqual(response.events.filter { (0..<100).contains($0.time) }.count, 0)
    XCTAssertEqual(response.events.filter { (100...).contains($0.time) }.count, 1)
  }

  func testDidExitPreloadState() {
    let scheduler = TestScheduler(initialClock: 0)
    let node = ASDisplayNode()
    _ = node.view

    scheduler.scheduleAt(100) { node.didExitPreloadState() }

    let response = scheduler.start(created: 0, subscribed: 0, disposed: 100) {
      node.rx.didExitPreloadState
    }

    XCTAssertEqual(response.events.filter { (0..<100).contains($0.time) }.count, 0)
    XCTAssertEqual(response.events.filter { (100...).contains($0.time) }.count, 1)
  }

  func testDidLoad() {
    let scheduler = TestScheduler(initialClock: 0)
    let node = ASDisplayNode()
    _ = node.view

    scheduler.scheduleAt(100) { node.didLoad() }

    let response = scheduler.start(created: 0, subscribed: 0, disposed: 100) {
      node.rx.didLoad
    }

    XCTAssertEqual(response.events.filter { (0..<100).contains($0.time) }.count, 0)
    XCTAssertEqual(response.events.filter { (100...).contains($0.time) }.count, 1)
  }

  func testHidden_True() {
    let node = ASDisplayNode()
    Observable.just(true).subscribe(node.rx.isHidden).dispose()

    XCTAssertEqual(node.isHidden, true)
  }

  func testHidden_False() {
    let node = ASDisplayNode()
    Observable.just(false).subscribe(node.rx.isHidden).dispose()

    XCTAssertEqual(node.isHidden, false)
  }

  func testAlpha_0() {
    let node = ASDisplayNode()
    Observable.just(0).subscribe(node.rx.alpha).dispose()

    XCTAssertEqual(node.alpha, 0)
  }

  func testAlpha_1() {
    let node = ASDisplayNode()
    Observable.just(1).subscribe(node.rx.alpha).dispose()

    XCTAssertEqual(node.alpha, 1)
  }

  func testBackgroundColor() {
    let node = ASDisplayNode()
    let color: UIColor = .red

    Observable.just(color).subscribe(node.rx.backgroundColor).dispose()

    XCTAssertEqual(node.backgroundColor, color)
  }

  func testBackgroundColor_optionalSome() {
    let node = ASDisplayNode()
    let color: UIColor? = .red

    Observable.just(color).subscribe(node.rx.backgroundColor).dispose()

    XCTAssertEqual(node.backgroundColor, color)
  }

  func testBackgroundColor_optionalNil() {
    let node = ASDisplayNode()
    let color: UIColor? = nil

    Observable.just(color).subscribe(node.rx.backgroundColor).dispose()

    XCTAssertEqual(node.backgroundColor, color)
  }

  func testSetNeedsLayout() {
    class TestNode: ASDisplayNode {
      var didSetNeedsLayout: Bool = false

      override func setNeedsLayout() {
        self.didSetNeedsLayout = true
      }
    }

    let node = TestNode()
    XCTAssertEqual(node.didSetNeedsLayout, false)

    Observable.just(()).subscribe(node.rx.setNeedsLayout).dispose()

    XCTAssertEqual(node.didSetNeedsLayout, true)
  }
}
