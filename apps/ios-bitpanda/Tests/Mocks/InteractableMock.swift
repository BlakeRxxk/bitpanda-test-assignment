//
//  InteractableMock.swift
//  AppLibraryTests
//
//
//import Foundation
//import BitPandaCore
//import Combine
//
//@testable import apps_ios_bitpanda_AppLibrary
//
//public class InteractableMock: Interactable {
//    public init() {}
//
//    public init(isActive: Bool = false, isActiveStream: Observable<Bool> = PublishSubject<Bool>()) {
//        self.isActive = isActive
//        self.isActiveStream = isActiveStream
//    }
//
//
//    public private(set) var isActiveSetCallCount = 0
//    public var isActive: Bool = false { didSet { self.isActiveSetCallCount += 1 } }
//
//
//    public private(set) var activateCallCount = 0
//    public var activateHandler: (() -> ())?
//    public func activate() {
//        self.activateCallCount += 1
//        if let activateHandler = activateHandler {
//            activateHandler()
//        }
//    }
//
//    public private(set) var deactivateCallCount = 0
//    public var deactivateHandler: (() -> ())?
//    public func deactivate() {
//        self.deactivateCallCount += 1
//        if let deactivateHandler = deactivateHandler {
//            deactivateHandler()
//        }
//    }
//}
