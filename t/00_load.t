#!perl -w

use strict;
use Test::More tests => 3;

require_ok 'MouseX::MethodAttributes';
require_ok 'MouseX::MethodAttributes::Inheritable';

can_ok('MouseX::MethodAttributes::Inheritable',
    'MODIFY_CODE_ATTRIBUTES');

diag "Testing MouseX::MethodAttributes/$MouseX::MethodAttributes::VERSION";

