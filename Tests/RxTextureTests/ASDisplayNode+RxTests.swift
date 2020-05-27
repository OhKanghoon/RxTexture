//
//  ASDisplayNode+RxTests.swift
//  RxTextureTests
//
//  Created by KanghoonOh on 21/11/2019.
//

import XCTest

import AsyncDisplayKit
import RxExpect
import RxSwift
import RxTexture

final class ASDisplayNodeTests: XCTestCase {
  func testDidEnterVisibleState() {
    let test = RxExpect()
    let node = ASDisplayNode()
    _ = node.view
    test.scheduler.scheduleAt(100) { node.didEnterVisibleState() }
    test.assert(node.rx.didEnterVisibleState) { events in
      XCTAssertEqual(events.in(..<100).filter(.next).count, 0)
      XCTAssertEqual(events.in(100...).filter(.next).count, 1)
    }
  }

  func testDidExitVisibleState() {
    let test = RxExpect()
    let node = ASDisplayNode()
    _ = node.view
    test.scheduler.scheduleAt(100) { node.didExitVisibleState() }
    test.assert(node.rx.didExitVisibleState) { events in
      XCTAssertEqual(events.in(..<100).filter(.next).count, 0)
      XCTAssertEqual(events.in(100...).filter(.next).count, 1)
    }
  }

  func testDidEnterDisplayState() {
    let test = RxExpect()
    let node = ASDisplayNode()
    test.scheduler.scheduleAt(100) { node.didEnterDisplayState() }
    test.assert(node.rx.didEnterDisplayState) { events in
      XCTAssertEqual(events.in(..<100).filter(.next).count, 0)
      XCTAssertEqual(events.in(100...).filter(.next).count, 1)
    }
  }

  func testDidExitDisplayState() {
    let test = RxExpect()
    let node = ASDisplayNode()
    test.scheduler.scheduleAt(100) { node.didExitDisplayState() }
    test.assert(node.rx.didExitDisplayState) { events in
      XCTAssertEqual(events.in(..<100).filter(.next).count, 0)
      XCTAssertEqual(events.in(100...).filter(.next).count, 1)
    }
  }

  func testDidEnterPreloadState() {
    let test = RxExpect()
    let node = ASDisplayNode()
    test.scheduler.scheduleAt(100) { node.didEnterPreloadState() }
    test.assert(node.rx.didEnterPreloadState) { events in
      XCTAssertEqual(events.in(..<100).filter(.next).count, 0)
      XCTAssertEqual(events.in(100...).filter(.next).count, 1)
    }
  }

  func testDidExitPreloadState() {
    let test = RxExpect()
    let node = ASDisplayNode()
    test.scheduler.scheduleAt(100) { node.didExitPreloadState() }
    test.assert(node.rx.didExitPreloadState) { events in
      XCTAssertEqual(events.in(..<100).filter(.next).count, 0)
      XCTAssertEqual(events.in(100...).filter(.next).count, 1)
    }
  }

  func testDidLoad() {
    let test = RxExpect()
    let node = ASDisplayNode()
    test.scheduler.scheduleAt(100) { node.didLoad() }
    test.assert(node.rx.didLoad) { events in
      XCTAssertEqual(events.in(..<100).filter(.next).count, 0)
      XCTAssertEqual(events.in(100...).filter(.next).count, 1)
    }
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
