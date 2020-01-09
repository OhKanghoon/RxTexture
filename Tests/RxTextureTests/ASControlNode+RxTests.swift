//
//  ASControlNode+RxTests.swift
//  RxTextureTests
//
//  Created by ohkanghoon on 21/11/2019.
//

import XCTest

import AsyncDisplayKit
import RxExpect
import RxSwift
import RxTexture

final class ASControlNodeTests: XCTestCase {
  func testEnabled_True() {
    let node = ASControlNode()
    Observable.just(true).subscribe(node.rx.isEnabled).dispose()

    XCTAssertEqual(node.isEnabled, true)
  }

  func testEnabled_False() {
    let node = ASControlNode()
    Observable.just(false).subscribe(node.rx.isEnabled).dispose()

    XCTAssertEqual(node.isEnabled, false)
  }

  func testSelected_True() {
    let node = ASControlNode()
    Observable.just(true).subscribe(node.rx.isSelected).dispose()

    XCTAssertEqual(node.isSelected, true)
  }

  func testSelected_False() {
    let node = ASControlNode()
    Observable.just(false).subscribe(node.rx.isSelected).dispose()

    XCTAssertEqual(node.isSelected, false)
  }

  func testHighlighted_True() {
    let node = ASControlNode()
    Observable.just(true).subscribe(node.rx.isHighlighted).dispose()

    XCTAssertEqual(node.isHighlighted, true)
  }

  func testHighlighted_False() {
    let node = ASControlNode()
    Observable.just(false).subscribe(node.rx.isHighlighted).dispose()

    XCTAssertEqual(node.isHighlighted, false)
  }

  func testSubscribeHighlighted() {
    final class UITouchStub: UITouch {
      override var tapCount: Int {
        return 1
      }
    }

    let node = ASControlNode()
    let disposeBag = DisposeBag()
    var isHighlighted: Bool = false
    node.rx.isHighlighted.subscribe(onNext: { isHighlighted = $0 }).disposed(by: disposeBag)

    node.touchesBegan([UITouchStub()], with: nil)
    XCTAssertEqual(isHighlighted, true)

    node.touchesBegan([UITouchStub()], with: nil)
    node.touchesEnded([UITouchStub()], with: nil)
    XCTAssertEqual(isHighlighted, false)

    node.touchesBegan([UITouchStub()], with: nil)
    node.touchesCancelled([UITouchStub()], with: nil)
    XCTAssertEqual(isHighlighted, false)
  }

  func testControl_EventCompletesOnDealloc() {
    let createNode: () -> ASControlNode = { ASControlNode() }
    ensureEventDeallocated(createNode) { (node: ASControlNode) in node.rx.controlEvent(.allEvents) }
    ensurePropertyDeallocated(createNode, "1") { (node: ASControlNode) in
      var value = "1"
      return node.rx.controlProperty(
        editingEvents: [.allEvents],
        getter: { _ -> String in value },
        setter: { (_, newValue) in value = newValue }
      )
    }
  }

  func test_controlEvent() {
    let node = ASControlNode()

    var numberOfTimesReceivedValueChanged = 0
    var numberOfTimesReceivedTouchUpInside = 0

    let d1 = node.rx.controlEvent([.valueChanged]).subscribe(onNext: { numberOfTimesReceivedValueChanged += 1 })
    let d2 = node.rx.controlEvent([.valueChanged]).subscribe(onNext: { numberOfTimesReceivedValueChanged += 1 })

    XCTAssertEqual(numberOfTimesReceivedValueChanged, 0)

    node.sendActions(forControlEvents: .valueChanged, with: nil)
    XCTAssertEqual(numberOfTimesReceivedValueChanged, 2)

    d1.dispose()
    d2.dispose()

    let d3 = node.rx.controlEvent([.valueChanged]).subscribe(onNext: { numberOfTimesReceivedValueChanged += 1 })
    let d4 = node.rx.controlEvent([.valueChanged]).subscribe(onNext: { numberOfTimesReceivedValueChanged += 1 })

    XCTAssertEqual(numberOfTimesReceivedValueChanged, 2)

    node.sendActions(forControlEvents: .valueChanged, with: nil)
    XCTAssertEqual(numberOfTimesReceivedValueChanged, 4)

    _ = node.rx.controlEvent([.touchUpInside]).subscribe(onNext: { numberOfTimesReceivedTouchUpInside += 1 })
    _ = node.rx.controlEvent([.touchUpInside]).subscribe(onNext: { numberOfTimesReceivedTouchUpInside += 1 })

    XCTAssertEqual(numberOfTimesReceivedValueChanged, 4)
    XCTAssertEqual(numberOfTimesReceivedTouchUpInside, 0)

    node.sendActions(forControlEvents: .touchUpInside, with: nil)
    XCTAssertEqual(numberOfTimesReceivedValueChanged, 4)
    XCTAssertEqual(numberOfTimesReceivedTouchUpInside, 2)

    node.sendActions(forControlEvents: .valueChanged, with: nil)
    XCTAssertEqual(numberOfTimesReceivedValueChanged, 6)
    XCTAssertEqual(numberOfTimesReceivedTouchUpInside, 2)

    d3.dispose()
    d4.dispose()
  }

  func test_controlProperty() {
    let node = ASControlNode()

    var receivedValues = [String]()

    var value = ""

    let property = node.rx.controlProperty(
      editingEvents: [.valueChanged],
      getter: { _ in
        value
      },
      setter: { (_, newValue) in
        fatalError()
      }
    )

    value = "a"

    XCTAssertEqual(receivedValues, [])

    let d1 = property.asObservable().subscribe(onNext: { receivedValues.append($0) })
    let d2 = property.asObservable().subscribe(onNext: { receivedValues.append($0) })

    XCTAssertEqual(receivedValues, ["a", "a"])

    value = "b"

    node.sendActions(forControlEvents: .touchUpInside, with: nil)
    XCTAssertEqual(receivedValues, ["a", "a"])

    node.sendActions(forControlEvents: .valueChanged, with: nil)

    XCTAssertEqual(receivedValues, ["a", "a", "b", "b"])

    d1.dispose()
    d2.dispose()

    _ = property.asObservable().subscribe(onNext: { receivedValues.append($0) })
    _ = property.asObservable().subscribe(onNext: { receivedValues.append($0) })

    XCTAssertEqual(receivedValues, ["a", "a", "b", "b", "b", "b"])

    value = "c"

    node.sendActions(forControlEvents: .touchUpInside, with: nil)
    XCTAssertEqual(receivedValues, ["a", "a", "b", "b", "b", "b"])

    node.sendActions(forControlEvents: .valueChanged, with: nil)
    XCTAssertEqual(receivedValues, ["a", "a", "b", "b", "b", "b", "c", "c"])
  }
}
