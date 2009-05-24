package Audio::File::Mp3::Tag;

use strict;
use warnings;
use base qw( Audio::File::Tag );
use MP3::Tag;

our $VERSION = '0.05';

sub init {
	my $self = shift;
	$self->{mp3} = MP3::Tag->new( $self->{filename} ) or return;
	$self->{mp3}->get_tags();

	my $info = $self->{mp3}->autoinfo;
	my $track = $info->{track};
	my $pos = index($track, '/');

	$track = substr($track, 0, $pos) if ($pos != -1);

	$self->title  (	$info->{ title   } );
	$self->artist (	$info->{ artist  } );
	$self->album  (	$info->{ album   } );
	$self->comment(	$info->{ comment } );
	$self->genre  (	$info->{ genre   } );
	$self->year   (	$info->{ year    } );
	$self->track  (	$track             );
	$self->total  (	substr($track, $pos + 1) );

	if (exists $self->{mp3}->{ID3v2}) {
	  my $disctag = 0;
	  if ($self->{mp3}->{ID3v2}->get_frame("TPA")) {
	    $disctag = $self->{mp3}->{ID3v2}->get_frame("TPA");
	  }elsif ($self->{mp3}->{ID3v2}->get_frame("TPOS")) {
	    $disctag = $self->{mp3}->{ID3v2}->get_frame("TPOS");
	  }else {
	    return 1;
	  }
	  my $disctotal = 0;
	  my $disc = 0;
	  if ($disctag =~ /\//) {
	    ($disc, $disctotal) = split(/\//,$disctag,2);
	  }else {
	    $disc = $disctag;
	  }
	  $self->disc ( $disc );
	}

	return 1;
}

1;
