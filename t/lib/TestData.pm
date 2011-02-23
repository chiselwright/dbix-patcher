package # hide from PAUSE
    TestData;
# vim: ts=8 sts=4 et sw=4 sr sta
use strict;
use warnings;

use Patcher::Schema;

# lifted from DBIx::Class' DBICTest.pm
sub _database {
    my $self = shift;
    my $db_file = "t/var/DBIxClass.db";

    unlink($db_file) if -e $db_file;
    unlink($db_file . "-journal") if -e $db_file . "-journal";
    mkdir("t/var") unless -d "t/var";

    my $dsn = $ENV{"DBICTEST_DSN"} || "dbi:SQLite:${db_file}";
    my $dbuser = $ENV{"DBICTEST_DBUSER"} || '';
    my $dbpass = $ENV{"DBICTEST_DBPASS"} || '';

    my @connect_info = ($dsn, $dbuser, $dbpass, { AutoCommit => 1 });

    return @connect_info;
}

# lifted from DBIx::Class' DBICTest.pm
sub init_schema {
    my $self = shift;
    my %args = @_;

    my $schema;

    if ($args{compose_connection}) {
      $schema = Patcher::Schema->compose_connection(
                  'Patcher', $self->_database
                );
    } else {
      $schema = Patcher::Schema->compose_namespace('Patcher');
    }
    if ( !$args{no_connect} ) {
      $schema = $schema->connect($self->_database);
      $schema->storage->on_connect_do(['PRAGMA synchronous = OFF']);
    }
    if ( !$args{no_deploy} ) {
        __PACKAGE__->deploy_schema( $schema );
        __PACKAGE__->populate_schema( $schema ) if( !$args{no_populate} );
    }
    return $schema;
}

# lifted from DBIx::Class' DBICTest.pm
sub deploy_schema {
    my $self = shift;
    my $schema = shift;

    if ($ENV{"DBICTEST_SQLT_DEPLOY"}) {
        return $schema->deploy();
    } else {
        open IN, "t/lib/sqlite.sql";
        my $sql;
        { local $/ = undef; $sql = <IN>; }
        close IN;
        ($schema->storage->dbh->do($_) || print "Error on SQL: $_\n") for split(/;\n/, $sql);
    }
}

sub populate_schema {
    my $self    = shift;
    my $schema  = shift;

    # see the following for an example:
    # https://github.com/chiselwright/test-dbix-class-schema/blob/master/t/lib/TDCSTest.pm#L68
}

1;
