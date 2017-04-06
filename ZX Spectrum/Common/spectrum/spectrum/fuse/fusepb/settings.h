/* settings.h: Handling configuration settings
   Copyright (c) Copyright (c) 2001-2003 Philip Kendall, Fredrick Meunier

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License along
   with this program; if not, write to the Free Software Foundation, Inc.,
   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

   Author contact information:

   E-mail: philip-fuse@shadowmagic.org.uk

*/

#include "config.h"

#include <sys/types.h>

#ifndef FUSE_SETTINGS_H
#define FUSE_SETTINGS_H

typedef struct settings_cocoa settings_cocoa;

typedef struct settings_info {

   int accelerate_loader;
   int aspect_hint;
   int auto_load;
   int autosave_settings;
   int beta128;
   int beta128_48boot;
  char *betadisk_file;
   int bilinear_filter;
   int bw_tv;
   int competition_code;
   int competition_mode;
   int confirm_actions;
  char *dck_file;
  char *debugger_command;
   int detect_loader;
   int didaktik80;
  char *didaktik80disk_file;
   int disciple;
  char *discipledisk_file;
   int disk_ask_merge;
  char *disk_try_merge;
   int divide_enabled;
  char *divide_master_file;
  char *divide_slave_file;
   int divide_wp;
   int doublescan_mode;
   int drive_40_max_track;
   int drive_80_max_track;
  char *drive_beta128a_type;
  char *drive_beta128b_type;
  char *drive_beta128c_type;
  char *drive_beta128d_type;
  char *drive_didaktik80a_type;
  char *drive_didaktik80b_type;
  char *drive_disciple1_type;
  char *drive_disciple2_type;
  char *drive_opus1_type;
  char *drive_opus2_type;
  char *drive_plus3a_type;
  char *drive_plus3b_type;
  char *drive_plusd1_type;
  char *drive_plusd2_type;
   int embed_snapshot;
   int emulation_speed;
   int fastload;
   int fb_mode;
   int frame_rate;
   int full_screen;
   int full_screen_panorama;
   int fuller;
  char *if2_file;
   int interface1;
   int interface2;
   int issue2;
   int joy1_number;
   int joy1_xaxis;
   int joy1_yaxis;
   int joy2_number;
   int joy2_xaxis;
   int joy2_yaxis;
   int joy_kempston;
   int joy_keyboard;
   int joy_prompt;
  char *joystick_1;
   int joystick_1_fire_1;
   int joystick_1_fire_10;
   int joystick_1_fire_11;
   int joystick_1_fire_12;
   int joystick_1_fire_13;
   int joystick_1_fire_14;
   int joystick_1_fire_15;
   int joystick_1_fire_2;
   int joystick_1_fire_3;
   int joystick_1_fire_4;
   int joystick_1_fire_5;
   int joystick_1_fire_6;
   int joystick_1_fire_7;
   int joystick_1_fire_8;
   int joystick_1_fire_9;
   int joystick_1_output;
  char *joystick_2;
   int joystick_2_fire_1;
   int joystick_2_fire_10;
   int joystick_2_fire_11;
   int joystick_2_fire_12;
   int joystick_2_fire_13;
   int joystick_2_fire_14;
   int joystick_2_fire_15;
   int joystick_2_fire_2;
   int joystick_2_fire_3;
   int joystick_2_fire_4;
   int joystick_2_fire_5;
   int joystick_2_fire_6;
   int joystick_2_fire_7;
   int joystick_2_fire_8;
   int joystick_2_fire_9;
   int joystick_2_output;
   int joystick_keyboard_down;
   int joystick_keyboard_fire;
   int joystick_keyboard_left;
   int joystick_keyboard_output;
   int joystick_keyboard_right;
   int joystick_keyboard_up;
   int kempston_mouse;
   int late_timings;
  char *mdr_file;
  char *mdr_file2;
  char *mdr_file3;
  char *mdr_file4;
  char *mdr_file5;
  char *mdr_file6;
  char *mdr_file7;
  char *mdr_file8;
   int mdr_len;
   int mdr_random_len;
   int melodik;
   int mouse_swap_buttons;
  char *movie_compr;
  char *movie_start;
   int movie_stop_after_rzx;
   int opus;
  char *opusdisk_file;
   int pal_tv2x;
  char *playback_file;
   int plus3_detect_speedlock;
  char *plus3disk_file;
   int plusd;
  char *plusddisk_file;
   int preferences_tab;
   int printer;
  char *printer_graphics_filename;
  char *printer_text_filename;
   int raw_s_net;
  char *record_file;
   int recreated_spectrum;
  char *rom_128_0;
  char *rom_128_1;
  char *rom_16_0;
  char *rom_2048_0;
  char *rom_2068_0;
  char *rom_2068_1;
  char *rom_48_0;
  char *rom_beta128;
  char *rom_didaktik80;
  char *rom_disciple;
  char *rom_interface1;
  char *rom_opus;
  char *rom_pentagon1024_0;
  char *rom_pentagon1024_1;
  char *rom_pentagon1024_2;
  char *rom_pentagon1024_3;
  char *rom_pentagon512_0;
  char *rom_pentagon512_1;
  char *rom_pentagon512_2;
  char *rom_pentagon512_3;
  char *rom_pentagon_0;
  char *rom_pentagon_1;
  char *rom_pentagon_2;
  char *rom_plus2_0;
  char *rom_plus2_1;
  char *rom_plus2a_0;
  char *rom_plus2a_1;
  char *rom_plus2a_2;
  char *rom_plus2a_3;
  char *rom_plus3_0;
  char *rom_plus3_1;
  char *rom_plus3_2;
  char *rom_plus3_3;
  char *rom_plus3e_0;
  char *rom_plus3e_1;
  char *rom_plus3e_2;
  char *rom_plus3e_3;
  char *rom_plusd;
  char *rom_scorpion_0;
  char *rom_scorpion_1;
  char *rom_scorpion_2;
  char *rom_scorpion_3;
  char *rom_se_0;
  char *rom_se_1;
  char *rom_speccyboot;
  char *rom_ts2068_0;
  char *rom_ts2068_1;
  char *rom_usource;
   int rs232_handshake;
  char *rs232_rx;
  char *rs232_tx;
   int rzx_autosaves;
   int rzx_compression;
   int simpleide_active;
  char *simpleide_master_file;
  char *simpleide_slave_file;
   int slt_traps;
  char *snapshot;
  char *snet;
   int sound;
  char *sound_device;
   int sound_force_8bit;
   int sound_freq;
   int sound_load;
  char *speaker_type;
   int speccyboot;
  char *speccyboot_tap;
   int specdrum;
   int spectranet;
   int spectranet_disable;
  char *start_machine;
  char *start_scaler_mode;
   int statusbar;
  char *stereo_ay;
   int strict_aspect_hint;
  char *svga_modes;
  char *tape_file;
   int tape_traps;
   int unittests;
   int usource;
   int volume_ay;
   int volume_beeper;
   int volume_specdrum;
   int writable_roms;
   int z80_is_cmos;
   int zxatasp_active;
  char *zxatasp_master_file;
  char *zxatasp_slave_file;
   int zxatasp_upload;
   int zxatasp_wp;
   int zxcf_active;
  char *zxcf_pri_file;
   int zxcf_upload;
   int zxprinter;

  settings_cocoa *cocoa;

  int show_help;
  int show_version;

} settings_info;

extern settings_info settings_current;
extern settings_info settings_default;

int settings_init( int *first_arg, int argc, char **argv );
void settings_defaults( settings_info *settings );
void settings_copy( settings_info *dest, settings_info *src );

#define SETTINGS_ROM_COUNT 32
extern const char *settings_rom_name[ SETTINGS_ROM_COUNT ];
char **settings_get_rom_setting( settings_info *settings, size_t which,
				 int is_peripheral );

void settings_set_string( char **string_setting, const char *value );

int settings_free( settings_info *settings );

int read_config_file( settings_info *settings );
int settings_write_config( settings_info *settings );

void settings_register_startup( void );

#endif				/* #ifndef FUSE_SETTINGS_H */
