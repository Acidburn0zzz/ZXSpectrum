/* PreferencesController.h: Routines for dealing with the Preferences Panel
   Copyright (c) 2005 Fredrick Meunier

   $Id: PreferencesController.h,v 1.1 2005/04/18 02:55:20 fred Exp $

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

   Author contact information:

   E-mail: pak21-fuse@srcf.ucam.org
   Postal address: 15 Crescent Road, Wokingham, Berks, RG40 2DB, England

*/

#import <AppKit/AppKit.h>

@class JoystickConfigurationController;

@interface PreferencesController : NSWindowController
{
  IBOutlet NSFormCell *rom0Filename;
  IBOutlet NSFormCell *rom1Filename;
  IBOutlet NSFormCell *rom2Filename;
  IBOutlet NSFormCell *rom3Filename;
  IBOutlet NSArrayController *machineRomsController;
  IBOutlet NSMatrix *massStorageType;
  IBOutlet NSMatrix *externalSoundType;
  IBOutlet NSTabView *tabView;
  IBOutlet NSToolbar *toolbar;
  IBOutlet NSView *generalPrefsView;
  IBOutlet NSView *soundPrefsView;
  IBOutlet NSView *peripheralsPrefsView;
  IBOutlet NSView *rzxPrefsView;
  IBOutlet NSView *joysticksPrefsView;
  IBOutlet NSView *romPrefsView;
  IBOutlet NSView *machinePrefsView;
  IBOutlet NSView *filterPrefsView;

  JoystickConfigurationController *joystickConfigurationController;

  NSMutableArray *machineRoms;
  NSArray *speakerTypes;
  NSArray *soundStereoAY;
  NSArray *diskTryMerge;
  NSArray *movieCompression;
}
+ (void)initialize;

- (void)windowDidLoad;
- (void)windowDidMove:(NSNotification *)aNotification;
- (void)showWindow:(id)sender;
- (void)handleWillClose:(NSNotification *)note;
- (IBAction)chooseFile:(id)sender;
- (IBAction)setup:(id)sender;
- (NSArray *)machines;
- (NSArray *)joysticks;
- (NSArray *)sdlJoysticks;
- (IBAction)chooseROMFile:(id)sender;
- (IBAction)resetROMFile:(id)sender;
- (IBAction)resetUserDefaults:(id)sender;
- (IBAction)massStorageTypeClicked:(id)sender;
- (IBAction)externalSoundTypeClicked:(id)sender;
- (IBAction)selectPrefPanel:(id)item;
- (NSArray *)toolbarSelectableItemIdentifiers:(NSToolbar *)bar;
- (void)setMassStorageType;
- (void)setExternalSoundType;

- (unsigned int)countOfMachineRoms;
- (id)objectInMachineRomsAtIndex:(unsigned int)index;
- (void)insertObject:(id)anObject inMachineRomsAtIndex:(unsigned int)index;
- (void)removeObjectFromMachineRomsAtIndex:(unsigned int)index;
- (void)replaceObjectInMachineRomsAtIndex:(unsigned int)index withObject:(id)anObject;

@end
