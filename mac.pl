#!/usr/bin/perl
# randmal.pl - random MAC address generator
# Copyright (C) 2013 Ian Campbell
#
my $agpl = <<EOL;
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
EOL

use strict;
use warnings;

use CGI qw/:standard -nosticky/;
use CGI::Carp qw(fatalsToBrowser);

### Parameters

if ( defined param("source") ) {
    print header( -type => 'text/plain', -charset => 'utf-8' );
    open SELF, "<$0" or die "cannot open self";
    print <SELF>;
    close SELF;
    exit 0;
}

my $default_scope = "local";
my %scope_labels  = (
    'local'  => "Locally Administered",
    'global' => "Globally Unique (OUI Enforced)"
);

my $default_type = "unicast";
my %type_labels  = (
    'multicast' => "Multicast",
    'unicast'   => "Unicast"
);

my $scope = param("scope") || $default_scope;
$scope = $default_scope unless $scope_labels{$scope};
my $local  = $scope eq "local";
my $global = $scope eq "global";

my $type = param("type") || $default_type;
$type = $default_type unless $type_labels{$type};
my $unicast   = $type eq "unicast";
my $multicast = $type eq "multicast";

### Generate the address

my ( @bytes, @address, $warning );

if ($local) {
    @bytes = map { int( rand(256) ) } ( 0 .. 5 );

    #$warning = sprintf( "<tt>%#08b</tt>", $bytes[0] );
}
elsif ($global) {
    if ( defined param("oui") ) {
        @bytes = ( 0, 0, 0 );
        push @bytes, map { int( rand(256) ) } ( 0 .. 2 );

# Pairs of hex digits, seperated by any character or none. Accepts common formats:
# aa:bb:cc
# aa-bb-cc
# aabb.cc
# etc
        if ( param("oui") =~
            m/^\s*([[:xdigit:]]{2}).?([[:xdigit:]]{2}).?([[:xdigit:]]{2}).*/ )
        {
            $bytes[0] = hex($1);
            $bytes[1] = hex($2);
            $bytes[2] = hex($3);

            $warning = "OUI had locally administered bit set, will clear"
              if $bytes[0] & 0x2;
        }
        else {
            $warning = "Failed to parse OUI";
        }
    }
    else {
        $warning = "You need to specify an OUI " . param("oui");
    }
}
else {
    $warning = "Unknown address scope &lsquo;$scope&rsquo;";
}

$bytes[0] &= 0xfc;
$bytes[0] |= 0x1 if $multicast;
$bytes[0] |= 0x2 if $local;

my @fmts = (
    "%02x:%02x:%02x:%02x:%02x:%02x",
    "%02x-%02x-%02x-%02x-%02x-%02x",
    "%02x%02x.%02x%02x.%02x%02x"
);
@address = map { sprintf( "<big><tt>$_</tt></big>", @bytes ) } @fmts
  if @bytes == 6;

### Print the page

my $script = <<END;
function updateOUI(value) {
    document.getElementById('oui').disabled = (value == "local");
}
function toggleLicense() {
    lic = document.getElementById('license');
    lic.style.display = lic.style.display == 'none' ? 'block' : 'none';
}

END

print header( -charset => 'utf-8', );

print start_html(
    -title  => "Random MAC Address Generator",
    -script => $script,
);

print h1(
    { -align => "center", },
    [
            "Random "
          . $scope_labels{$scope} . " "
          . $type_labels{$type}
          .

          " MAC Address:",
        @address,
        $warning ? "WARNING: $warning" : "",
    ]
);

my %textparams = ( -id => "oui", );
$textparams{-disabled} = "disabled" if $scope eq "local";

print start_form(
    -method  => "GET",
    -enctype => "application/x-www-form-urlencoded"
  ),
  p(
    { -align => "center" },
    label("Address&nbsp;Scope:"),
    popup_menu(
        -name     => "scope",
        -values   => [ "local", "global" ],
        -labels   => \%scope_labels,
        -default  => $default_scope,
        -onChange => "updateOUI(this.value)",
    ),
    label("OUI:"),
    textfield(
        %textparams,
        -name  => "oui",
        -value => scalar param("local")
    ),
    label("Address&nbsp;Class:"),
    popup_menu(
        -name    => "type",
        -values  => [ "unicast", "multicast" ],
        -labels  => \%type_labels,
        -default => $default_type,
    ),
    button( -name => "Generate Another", -onClick => "submit()" ),
  ),
  end_form,

  hr,

  p(
    { -align => "center" },
    small(
            "Copyright &copy; 2013 Ian Campbell &mdash; Licensed under the "
          . a( { -href => "javascript:toggleLicense();" }, "AGPL" ) . "; "
          . a( { -href => url() . "?source=1" }, "Get Source" )
    )
  ),
  pre( { -id => 'license', -style => "display: None" }, $agpl );
end_form();

print end_html();
