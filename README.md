# Sprinkler, Various Sprinkle Packages

## What is it?

This is a collection of [Sprinkle][1] recipes to use for your own
server stacks.

## Usage

In order to use Sprinkle, you will need a target server/host that you can
connect to via SSH. You must then have the Sprinkle gem installed on
your local machine:

    gem install sprinkle

After doing this, you will want to copy this repository to a local
directory, `cd`ing into it afterwards. To begin, first perform a `bundle
install`. At this point, you can start to try out the various packages
and policies within this repository.

For a brand new server, it is best to first create a user to issue all commands
through, as directly using _root_ is like playing with a vile of the bubonic
plague.

Luckily, a basic bootstrap policy is included. Before using it, you must
create a `bootstrap.rb` config file within the `config` directory:

    cp config/bootstrap.rb.example config/bootstrap.rb

Ensure that you create this file using the correct credentials, or else there
isn't much to expect out of this step. The variables set here are fairly self-
explanatory. However, it should be noted that the `include_ssh_authorized_keys`
setting will, if defined, will read the contents of the
`assets/user/ssh/authorized_keys` and insert it into the newly created user's
`authorized_keys` file (allowing you to immediately `SSH` into this account
after the policy is installed).

You can install this policy with the following command:

    sprinkle -s bootstrap.rb

Once you are finished with the bootstrap stage, you can forget about further
reliance on your server's _root_ user.

To use the rest of the recipes here, ensure you have correctly defined your
settings in the `config/deploy.rb` file (you can again create this by
copying the supplied `deploy.rb.example` file):

    cp config/deploy.rb.example config/deploy.rb

Moving on to the rest of the packages, you can install policies by issuing
commands in the following format:

    sprinkle -s install.rb <policy1 ... policyN>

You may now use any of the included Debian- and Ubuntu-based packages and
policies, or you can write your own.

Contributions are greatly appreciated! The goal of this repository is to
create a fully robust and fleshed-out group of packages and policies for
various DevOps needs.

### Other Sprinkle Stacks

This Sprinkle stack took inspiration from various sources, such as:

- [Plymouth Sprinkle Cookbook][2]
- [The Spritz Sprinkle Collection by Stuart Ellis][3]
- [The Rails Sprinkle Stack by Jonas Grimfelt][4]
- [Sprinkle-Packages by Mingalar][5]

## Contact

Email: <akiva@sixthirteen.co>

## TODO

- Further decouple bootstrap and deployment user processes
- Complete monitoring and backup tools
- Include other distributions (I am admittedly an Arch Linux fan, but server
  maintenance thereof is a huge bother).

## License

(The MIT License)

Copyright 2013, Akiva Levy

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[1]: https://github.com/sprinkle-tool/sprinkle "Sprinkle"
[2]: https://github.com/plymouthsoftware/sprinkle-cookbook "Plymouth Sprinkle Cookbook"
[3]: https://github.com/stuartellis/spritz "Spritz Sprinkle Collection"
[4]: https://github.com/grimen/sprinkle-stack "Rails Sprinkle Stack"
[5]: https://github.com/mingalar/sprinkle-packages "Sprinkle Packages"
