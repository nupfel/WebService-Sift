package WebService::Sift;

use Modern::Perl;
use Mouse;

# ABSTRACT: WebService::Sift - an interface to siftscience.com's Events, Score and Label APIs using Web::API

# VERSION

with 'Web::API';

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Some::Module;
    use Data::Dump 'dump';

=head1 SUBROUTINES/METHODS

=head2 method

=cut

has 'commands' => (
    is      => 'rw',
    default => sub {
        {
            # events
            create_order => {
                path               => 'events',
                default_attributes => { '$type' => '$create_order' },
                mandatory          => ['$type'],
            },
            transaction => {
                path               => 'events',
                default_attributes => { '$type' => '$transaction' },
                mandatory          => [ '$type', '$user_id' ],
            },
            create_account => {
                path               => 'events',
                default_attributes => { '$type' => '$create_account' },
                mandatory          => [ '$type', '$user_id' ],
            },
            update_account => {
                path               => 'events',
                default_attributes => { '$type' => '$update_account' },
                mandatory          => [ '$type', '$user_id' ],
            },
            add_item => {
                path               => 'events',
                default_attributes => { '$type' => '$add_item_to_cart' },
                mandatory          => ['$type'],
            },
            remove_item => {
                path               => 'events',
                default_attributes => { '$type' => '$remove_item_to_cart' },
                mandatory          => ['$type'],
            },
            submit_review => {
                path               => 'events',
                default_attributes => { '$type' => '$submit_review' },
                mandatory          => ['$type'],
            },
            send_message => {
                path               => 'events',
                default_attributes => { '$type' => '$send_message' },
                mandatory          => ['$type'],
            },
            login => {
                path               => 'events',
                default_attributes => { '$type' => '$login' },
                mandatory =>
                    [ '$type', '$user_id', '$session_id', '$login_status' ],
            },
            logout => {
                path               => 'events',
                default_attributes => { '$type' => '$logout' },
                mandatory          => [ '$type', '$user_id' ],
            },
            link_session_to_user => {
                path               => 'events',
                default_attributes => { '$type' => '$link_session_to_user' },
                mandatory          => [ '$type', '$user_id', '$session_id' ],
            },
            custom => {
                path      => 'events',
                mandatory => ['$type'],
            },

            # score
            score => {
                path      => 'score/:user_id',
                method    => 'GET',
                mandatory => ['api_key'],
            },

            # labels
            label => {
                path      => 'users/:$user_id/labels',
                mandatory => ['$is_bad']
            },
        };
    },
);

=head1 INTERNALS

=cut

sub commands {
    my ($self) = @_;
    return $self->commands;
}

=head2 BUILD

basic configuration for the client API happens usually in the BUILD method when using Web::API

=cut

sub BUILD {
    my ($self) = @_;

    $self->user_agent(__PACKAGE__ . ' ' . $WebService::Sift::VERSION);
    $self->default_method('POST');
    $self->content_type('application/json');
    $self->base_url('https://api.siftscience.com/v203');
    $self->auth_type('hash_key');
    $self->api_key_field('$api_key');

    return $self;
}

=head1 BUGS

Please report any bugs or feature requests on GitHub's issue tracker L<https://github.com/<github_user>/WebService::Sift/issues>.
Pull requests welcome.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WebService::Sift


You can also look for information at:

=over 4

=item * GitHub repository

L<https://github.com/<github_user>/WebService::Sift>

=item * MetaCPAN

L<https://metacpan.org/module/WebService::Sift>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WebService::Sift>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WebService::Sift>

=back

=cut

1;    # End of WebService::Sift
