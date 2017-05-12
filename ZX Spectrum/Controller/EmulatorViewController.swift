//
//  Created by Tomaz Kragelj on 26.03.17.
//  Copyright © 2017 Gentle Bytes. All rights reserved.
//

import UIKit
import CoreData
import Bond
import ReactiveKit

class EmulatorViewController: UIViewController {
	
	@IBOutlet fileprivate weak var spectrumView: SpectrumScreenView!
	@IBOutlet fileprivate weak var controlsContainerView: UIView!
	@IBOutlet fileprivate weak var spectrumInputView: UIView!
	
	@IBOutlet fileprivate weak var settingsButton: UIButton!
	@IBOutlet fileprivate weak var resetButton: UIButton!
	@IBOutlet fileprivate weak var filesButton: UIButton!
	@IBOutlet fileprivate weak var joystickButton: UIButton!
	@IBOutlet fileprivate weak var keyboardButton: UIButton!
	
	// MARK: - Data
	
	fileprivate var persistentContainer: NSPersistentContainer!
	
	fileprivate var isKeyboardVisible = false
	
	fileprivate var emulator: Emulator!
	fileprivate let viewWillHideBag = DisposeBag()
	
	// MARK: - Overriden functions

	override func viewDidLoad() {
		gverbose("Loading")
		
		super.viewDidLoad()
		
		inject(toView: spectrumInputView)
		
		gdebug("Setting up emulator")
		emulator = Emulator()!
		settings_defaults(&settings_current);
		read_config_file(&settings_current);
		spectrumView.hookToFuse()
		fuse_init(0, nil);
		
		let spectrum = SpectrumController()
		if let selected = spectrum.selectedMachine {
			Defaults.selectedMachine.value = spectrum.identifier(for: selected)
		}
		
		gdebug("Setting up view")
		settingsButton.image = IconsStyleKit.imageOfIconGear
		resetButton.image = IconsStyleKit.imageOfIconReset
		filesButton.image = IconsStyleKit.imageOfIconTape
		updateJoystickButtonIcon()
		updateKeyboardButtonIcon()

		setupEmulationStartedSignal()
		setupResetButtonSignals()
		setupJoystickButtonSignals()
		setupKeyboardButtonSignals()
		setupInputMethodSettingSignal()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		gverbose("Appearing")
		
		super.viewWillAppear(animated)
		
		gdebug("Preparing for appearance")
		teardownTapOnBackgroundInteraction()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		gverbose("Dissapearing")
		
		super.viewWillDisappear(animated)
		
		gdebug("Preparing for dissapearance")
		viewWillHideBag.dispose()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		Defaults.isEmulationStarted.value = false
		setupTapOnBackgroundInteraction()
		inject(toController: segue.destination)
	}
	
	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		return UIDevice.iPhone ? .portrait : [.portrait, .landscape]
	}
}

// MARK: - Dependencies

extension EmulatorViewController: PersistentContainerConsumer, PersistentContainerProvider {
	
	func configure(persistentContainer: NSPersistentContainer) {
		gdebug("Configuring with \(persistentContainer)")
		self.persistentContainer = persistentContainer
	}
	
	func providePersistentContainer() -> NSPersistentContainer {
		gdebug("Providing \(persistentContainer)")
		return persistentContainer
	}
}

extension EmulatorViewController: EmulatorProvider {
	
	func provideEmulator() -> Emulator {
		gdebug("Providing \(emulator)")
		return emulator
	}
}

// MARK: - User interface

extension EmulatorViewController {
	
	@IBAction func unwindToEmulatorViewController(segue: UIStoryboardSegue) {
		if let controller = segue.source as? SettingsViewController {
			controller.updateSettings()
		}
		Defaults.isEmulationStarted.value = true
	}
	
	fileprivate func updateJoystickButtonIcon(animated: Bool = false) {
		let image = isKeyboardVisible && Defaults.isInputJoystick.value ? IconsStyleKit.imageOfIconJoystickHide : IconsStyleKit.imageOfIconJoystickShow
		joystickButton.update(image: image, animated: animated)
	}
	
	fileprivate func updateKeyboardButtonIcon(animated: Bool = false) {
		let image = isKeyboardVisible && !Defaults.isInputJoystick.value ? IconsStyleKit.imageOfIconKeyboardHide : IconsStyleKit.imageOfIconKeyboardShow
		keyboardButton.update(image: image, animated: animated)
	}
}

// MARK: - Signals handling

extension EmulatorViewController {
	
	fileprivate func setupEmulationStartedSignal() {
		// Only handle the event if value is different from current one.
		Defaults.isEmulationStarted.skip(first: 1).distinct().bind(to: self) { me, value in
			ginfo("Updating emulation status")
			if value {
				me.emulator.unpause()
			} else {
				me.emulator.pause()
			}
		}
	}
	
	fileprivate func setupResetButtonSignals() {
		resetButton.reactive.tap.bind(to: self) { me, _ in
			ginfo("Resetting emulator")
			Defaults.currentObjectID.value = nil
			me.emulator.reset()
		}
	}
	
	fileprivate func setupJoystickButtonSignals() {
		joystickButton.reactive.tap.bind(to: self) { me, _ in
			ginfo("Toggling joystick")
			me.toggleKeyboard(asJoystick: true)
		}
	}
	
	fileprivate func setupKeyboardButtonSignals() {
		keyboardButton.reactive.tap.bind(to: self) { me, _ in
			ginfo("Toggling keyboard")
			me.toggleKeyboard()
		}
	}
	
	fileprivate func setupInputMethodSettingSignal() {
		// When input method changes, update the icons.
		Defaults.isInputJoystick.bind(to: self) { me, value in
			gverbose("Joystick input changed to \(value), updating icons")
			me.updateJoystickButtonIcon(animated: true)
			me.updateKeyboardButtonIcon(animated: true)
		}
	}
	
	private func toggleKeyboard(asJoystick: Bool = false) {
		func shouldHide() -> Bool {
			// If keyboard is not visible, we should show it.
			if !isKeyboardVisible {
				return false
			}
			
			// If keyboard is already visible in keyboard mode and user wants to change to joystick, we should remain showing it.
			if asJoystick && !Defaults.isInputJoystick.value {
				return false
			}
			
			// If keyboard is already visible in joystick mode and user wants to change to keyboard, we should remain showing it.
			if !asJoystick && Defaults.isInputJoystick.value {
				return false
			}
			
			// In all other cases, allow hiding it.
			return true
		}
		
		func animations() {
			spectrumInputView.isHidden = !isKeyboardVisible
		}

		// Update internal flag specifying whether keyboard is visible or not.
		isKeyboardVisible = !shouldHide()

		// Update user default specifying whether joystick or keyboard should be shown.
		Defaults.isInputJoystick.value = asJoystick

		// Animate keyboard in or out.
		InputView.animate(animations, completion: nil)
	}
}
