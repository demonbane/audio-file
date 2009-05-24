package Audio::File::Mp4::Tag;

use strict;
use warnings;
use base qw( Audio::File::Tag );
#use MP4::Info;

our $VERSION = '0.05';

sub init {
	my $self = shift;
	my $info = new MP4::Info $self->{filename};

 	$self->title  (	$info->title     );
 	$self->artist (	$info->artist    );
 	$self->album  (	$info->album     );
 	$self->comment(	$info->comment   );
 	$self->genre  (	$info->genre     );
 	$self->year   (	$info->year      );
 	$self->track  (	$info->trkn->[0] );
 	$self->total  (	$info->trkn->[1] );

	return 1;
}

1;
