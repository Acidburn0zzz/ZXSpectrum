//
//  Created by Tomaz Kragelj on 22.02.17.
//  Copyright © 2017 Gentle Bytes. All rights reserved.
//

import Foundation

/**
Executes the given handler on main thread. If already on main thread, handler is executed on the fly.
*/
func onMain(handler: @escaping () -> Void) {
	if Thread.isMainThread {
		handler()
	}
	
	DispatchQueue.main.async(execute: handler)
}

/**
Executes the given handler on next run loop cycle of the main thread.
*/
func onNextRunLoop(handler: @escaping () -> Void) {
	DispatchQueue.main.async(execute: handler)
}

/**
Simpler string localization.
*/
func NSLocalizedString(_ key: String) -> String {
	return NSLocalizedString(key, comment: "")
}
