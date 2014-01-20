# MVM

MVM is MPICH Version Manager.
Functions are only managing MPICH version.  
Please install requirements for building MPICH by yourself.

## Installation

Add this line to your application's Gemfile:

    gem 'mvm'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mvm



## Requirements
	* wget
	* make
	* gzip
	* tar
	* build tools for c, c++ and fortran etc...

## Usage
If install directory requires root permission, you must execute mvm by root or sudo.  

	mvm --help

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
