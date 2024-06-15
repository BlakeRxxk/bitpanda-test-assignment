////
////  RootInteractorTests.swift
////  AppLibraryTests
////
//
//import XCTest
//@testable import apps_ios_bitpanda_AppLibrary
//
//final class RootInteractorTests: XCTestCase {
//    private var presenter: RootPresentableMock!
//    private var router: RootRoutingMock!
//    private var listener: RootListenerMock!
//    private var interactor: RootInteractor!
//
//    override func setUp() {
//        super.setUp()
//        presenter = RootPresentableMock()
//        router = RootRoutingMock()
//        listener = RootListenerMock()
//
//        interactor = RootInteractor(presenter: presenter)
//
//        interactor.router = router
//        interactor.listener = listener
//    }
//
//    func test_when_didBecomeActive_called_it_should_be_call_attachTabs_from_router() {
//        // when
//        interactor.didBecomeActive()
//
//        // then
//        XCTAssertEqual(router.attachTabsCallCount, 1)
//    }
//}
