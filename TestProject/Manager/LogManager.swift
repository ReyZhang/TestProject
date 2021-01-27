//
//  LogManager.swift
//  TestProject
//
//  Created by rey zhang on 2021/1/13.
//

import Foundation
import CocoaLumberjack

public func logVerbose(_ message: @autoclosure () -> String) {
    DDLogVerbose(message())
}

public func logDebug(_ message: @autoclosure () -> String) {
    DDLogDebug(message())
}

public func logError(_ message: @autoclosure () -> String) {
    DDLogError(message())
}

public func logInfo(_ message: @autoclosure () -> String) {
    DDLogInfo(message())
}

public func logWarn(_ message: @autoclosure () -> String) {
    DDLogWarn(message())
}
