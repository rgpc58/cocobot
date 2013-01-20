# @brief
# @created 2013-01-19
# @date 2013-01-20
# @author Simon Rubinstein <ssimonrubinstein1@gmail.com>
# http://code.google.com/p/cocobot/
#
# copyright (c) Simon Rubinstein 2010-2013
# Id: $Id$
# Revision: $Revision$
# Date: $Date$
# Author: $Author$
# HeadURL: $HeadURL$
#
# cocobot is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# cocobot is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
# MA  02110-1301, USA.
package Cocoweb::Alert::Message;
use strict;
use warnings;
use Carp;
use Data::Dumper;
use Net::XMPP;
use Cocoweb;
use base 'Cocoweb::Object';

__PACKAGE__->attributes( 'name', 'write' );

##@method void init(%args)
#@brief Perform some initializations
sub init {
    my ( $self, %args ) = @_;
    my $conf = $args{'conf'};
    $self->attributes_defaults(
        'name'  => $conf->getString('name'),
        'write' => $conf->getArray('write')
    );
}

##@method void process($bot, $alarmCount, $users_ref)
#@brief Sends messages to users.
#@param object $bot A Cocoweb::Bot object
#@param integer $alarmCount The alarm number from 1 to n
#@param arrayref $users_ref List of users to process
sub process {
    my ( $self, $bot, $alarmCount, $users_ref ) = @_;
    foreach my $user (@$users_ref) {
        $user->messageSentTime(0);
        my $write_ref = $self->write();
        foreach my $write (@$write_ref) {
            $bot->requestWriteMessage( $user, $write );
        }
    }
}

1;

