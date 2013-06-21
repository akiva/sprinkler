# Sprinkler, Various Sprinkle Packages

## What is it?

This is a collection of [Sprinkle][1] recipes to use for your own
server stacks. For more information, read [An introduction to Sprinkle][2]

## Usage

In order to use Sprinkle, you will need a target server/host that you can
connect to via SSH. You must then have the Sprinkle gem installed on
your local machine:

    gem install sprinkle

After doing this, you will want to copy this repository to a local
directory, `cd`ing into it afterwards. To begin, first perform a `bundle
install`. At this point, you can start to try out the various packages
and policies within this repository by issuing the following command:

    sprinkle -s install.rb <policy1 ... policyN>

You may choose any of the included policies, or create your own. Be sure
to create your own `deploy.rb` file by copying over the included example
and replacing the credentials with those that pertain to your needs:

    cp config/deploy.rb.example config/deploy.rb

As well, if you choose to use the `authorized_keys` file, be sure to
fill in yours accordingly.

### Other Sprinkle Stacks

This Sprinkle stack owes a lot to:

- [The Spritz Sprinkle Collection by Stuart Ellis][4]
- [The Rails Sprinkle Stack by Jonas Grimfelt][5]
- [Sprinkle-Packages by Mingalar][6]

## Contact

Email: <akiva@sixthirteendesign.com>

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

[1]: https://github.com/crafterm/sprinkle/ "Sprinkle"
[2]: http://redartisan.com/2008/5/27/sprinkle-intro "Sprinkle introduction"

[4]: https://github.com/stuartellis/spritz "Spritz Sprinkle Collection"
[5]: https://github.com/grimen/sprinkle-stack "Rails Sprinkle Stack"
[6]: https://github.com/mingalar/sprinkle-packages "Sprinkle Packages"
