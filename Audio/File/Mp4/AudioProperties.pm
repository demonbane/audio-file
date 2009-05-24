package Audio::File::Mp4::AudioProperties;

use strict;
use warnings;
use base qw( Audio::File::AudioProperties );
use MP4::Info;

our $VERSION = '0.03';

sub init {
	my $self = shift;
	my $info = get_mp4info( $self->{filename} ) or return;

	$self->length( $info->{SECS} );
	$self->bitrate( $info->{BITRATE} );
	$self->sample_rate( $info->{FREQUENCY} * 1000 );

	return 1;
}

1;
