## Process this file with automake to produce Makefile.in
## Copyright (c) 2001 Philip Kendall

## $Id: Makefile.am,v 1.4 2007/02/02 16:21:56 pak21 Exp $

## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
##
## Author contact information:
##
## E-mail: philip-fuse@shadowmagic.org.uk

AUTOMAKE_OPTIONS = foreign

noinst_LIBRARIES = libuiaalib.a

libuiaalib_a_SOURCES = aalibdisplay.c aalibkeyboard.c aalibui.c error.c keysyms.c

BUILT_SOURCES = keysyms.c

keysyms.c: ../../keysyms.pl ../../keysyms.dat
	@PERL@ ../../keysyms.pl aa ../../keysyms.dat > $@

noinst_HEADERS = aalibkeyboard.h aalibui.h
