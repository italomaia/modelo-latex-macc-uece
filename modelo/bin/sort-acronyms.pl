#!/usr/bin/perl

#/***************************************************************************
# *   Copyright (C) 2010 by Sergio Luis O. B. Correia                       *
# *   sergio@larces.uece.br                                                 *
# *   Computer Networks and Security Laboratory (LARCES)                    *
# *   State University of Ceara (UECE/Brazil)                               *
# *                                                                         *
# *                                                                         *
# *   This program is free software; you can redistribute it and/or modify  *
# *   it under the terms of the GNU General Public License as published by  *
# *   the Free Software Foundation; either version 2 of the License, or     *
# *   (at your option) any later version.                                   *
# *                                                                         *
# *   This program is distributed in the hope that it will be useful,       *
# *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
# *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
# *   GNU General Public License for more details.                          *
# *                                                                         *
# *   You should have received a copy of the GNU General Public License     *
# *   along with this program; if not, write to the                         *
# *   Free Software Foundation, Inc.,                                       *
# *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
# ***************************************************************************/

use warnings;
use strict;

my $acronym_file = defined($ARGV[0]) ? $ARGV[0] : "";
if (! -e "$acronym_file") {
	print("file '$acronym_file' does not exist. exiting.\n");
	exit 1;
}

my %list = ();
my @lines = ();

open(LIST, "$acronym_file");
@lines = <LIST>;
close(LIST);

my $l;
foreach $l (@lines) {
	if ($l =~ /^\\contentsline {sigla}{\\hbox to\\\@tempdima {(.*?)\\hfil }{.*?}}{\d+}/) {
		my $key = lc($1);
		$list{"$key"} = $l;
	}
}

if (scalar(keys %list) > 0) {
	open(LIST, ">$acronym_file");
	foreach $l (sort (keys(%list))) {
		print LIST $list{"$l"};
	}
	close(LIST);
}