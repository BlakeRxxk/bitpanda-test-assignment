////
////  RootRouterTests.swift
////  AppLibraryTests
////
//
//import XCTest
//import BitPandaAssets
//@testable import apps_ios_bitpanda_AppLibrary
//
//final class RootRouterTests: XCTestCase {
//
//    private var assetsBuilder: AssetsBuildableMock!
//    private var walletsBuilder: WalletsBuildableMock!
//    private var interactor: RootInteractableMock!
//    private var viewController: RootViewControllableMock!
//    private var router: RootRouter!
//
//    override func setUp() {
//        super.setUp()
//        assetsBuilder = AssetsBuildableMock()
//        walletsBuilder = WalletsBuildableMock()
//        interactor = RootInteractableMock()
//        viewController = RootViewControllableMock()
//
//        router = RootRouter(
//            assetsBuilder: assetsBuilder,
//            walletsBuilder: walletsBuilder,
//            interactor: interactor,
//            viewController: viewController
//        )
//    }
//
//    func test_when_attachTabs_called_it_should_be_call_build_from_builders() {
//        // when
//        router.attachTabs()
//
//        // then
//        XCTAssertEqual(assetsBuilder.buildCallCount, 1)
//        XCTAssertEqual(walletsBuilder.buildCallCount, 1)
//        XCTAssertEqual(viewController.setViewControllersCallCount, 1)
//        XCTAssertEqual(router.children.count, 2)
//    }
//}
