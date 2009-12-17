package Audio::File::Mp4::Tag;

use strict;
use warnings;
use base qw( Audio::File::Tag );

our $VERSION = '0.05';

sub init {
	my $self = shift;
	my $info = new MP4::Info $self->{filename};

 	$self->title  (	$info->{NAM}     );
 	$self->artist (	$info->{ART}     );
 	$self->album  (	$info->{ALB}     );
 	$self->comment(	$info->{CMT}     );
 	$self->genre  (	$info->{GNRE}    );
 	$self->year   (	$info->{DAY}     );
 	$self->track  (	$info->{TRKN}[0] );
 	$self->total  (	$info->{TRKN}[1] );
	$self->disc   ( $info->{DISK}[0] );

	return 1;
}

1;
