//
//  Created by Tomaz Kragelj on 7.03.17.
//  Copyright © 2017 Gentle Bytes. All rights reserved.
//

import UIKit
import GCDWebServers

/// Manages web server for uploading files to application.
class WebServer: NSObject {
	
	fileprivate var server: GCDWebUploader? = nil
}

// MARK: - Managing server

extension WebServer {
	
	/// Starts the server.
	func start() throws {
		guard server == nil else {
			return
		}
		
		// Create files directory if it doesn't exist yet.
		let filesPath = try Database.createUploadFolder()
		
		gverbose("Starting server")
		UIApplication.shared.isIdleTimerDisabled = true
		server = GCDWebUploader(uploadDirectory: filesPath)
		server?.allowedFileExtensions = Database.allowedFileExtensions
		server?.allowHiddenItems = false
		server?.start()
	}
	
	/// Stops the server.
	func stop() {
		guard server != nil else {
			return
		}
		
		gverbose("Stopping server")
		UIApplication.shared.isIdleTimerDisabled = false
		server?.stop()
		server = nil
	}
}

// MARK: - Information

extension WebServer {
	
	/// Returns the server URL. Note this will return nil if server is not running.
	var serverURL: URL? {
		return server?.serverURL
	}
}
