package Patcher::Schema::Result::Patcher::Patch;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Patcher::Schema::Result::Patcher::Patch

=cut

__PACKAGE__->table("patcher.patch");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'patcher.patch_id_seq'

=head2 run_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 created

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 filename

  data_type: 'text'
  is_nullable: 0

=head2 basename

  data_type: 'text'
  is_nullable: 0

=head2 success

  data_type: 'boolean'
  default_value: false
  is_nullable: 1

=head2 b64digest

  data_type: 'text'
  is_nullable: 1

=head2 output

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "patcher.patch_id_seq",
  },
  "run_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "created",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "filename",
  { data_type => "text", is_nullable => 0 },
  "basename",
  { data_type => "text", is_nullable => 0 },
  "success",
  { data_type => "boolean", default_value => \"false", is_nullable => 1 },
  "b64digest",
  { data_type => "text", is_nullable => 1 },
  "output",
  { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 run

Type: belongs_to

Related object: L<Patcher::Schema::Result::Patcher::Run>

=cut

__PACKAGE__->belongs_to(
  "run",
  "Patcher::Schema::Result::Patcher::Run",
  { id => "run_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-02-19 15:51:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0y3Kut6HA1SU2kFbQV4DCA


sub is_successful {
    my($self) = @_;
    return $self->success;
}

1;
