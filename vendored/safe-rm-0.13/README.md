# safe-rm

prevention of accidental deletions by excluding important directories

Copyright (C) 2008-2020  Francois Marier <francois@fmarier.org>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

## How to use

Once you have installed safe-rm on your system (see `INSTALL`), you will need to
fill the system-wide or user-specific exclusions with the paths that you'd like
to protect against accidental deletion.

The system-wide exclusions live in `/etc/safe-rm.conf` (or `/usr/local/etc/safe-rm.conf`)
and you should probably add paths like these:

    /
    /etc
    /usr
    /usr/lib
    /var

The user-specific exclusions live in ~/.config/safe-rm and could include things like:

    /home/username/documents
    /home/username/documents/*
    /home/username/.mozilla

## Other approaches

If you want more protection than what safe-rm can offer, here are a few suggestions.

You could of couse request confirmation everytime you delete a file by putting this in
your /etc/bash.bashrc:

    alias rm='rm -i'

But this won't protect you from getting used to always saying yes, or from accidently
using 'rm -rf'.

Or you could make use of the Linux filesystem "immutable" attribute by marking (as root)
each file you want to protect:

    chattr +i file

Of course this is only usable on filesystems which support this feature.

Here are two projects which allow you to recover recently deleted files by trapping
all unlink(), rename() and open() system calls through the LD_PRELOAD facility:

* [delsafe](https://web.archive.org/web/20081027033142/http://homepage.esoterica.pt:80/~nx0yew/delsafe/)
* [libtrashcan](http://hpux.connect.org.uk/hppd/hpux/Development/Libraries/libtrash-0.2/readme.html)

There are also projects which implement the FreeDesktop.org trashcan spec. For example:

* [trash-cli](https://github.com/andreafrancia/trash-cli)

Finally, this project is a fork of GNU coreutils and adds features similar to safe-rm
to the rm command directly:

* [rmfd](https://github.com/d5h/rmfd)
