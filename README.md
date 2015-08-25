Cohoast 
===

Manage your hostfile in the terminal - ___v1.0.0___ _'Track Ballast'_ [♫](https://play.spotify.com/track/0pu6LHgjcYVQZPnPgxFbzi) 

![Logo above the lonely railroad](http://i.imgur.com/S0UDcX1.jpg "Influence your hostfile in the terminal")

[![Build Status](https://travis-ci.org/Krettis/cohoast.svg?branch=develop)](https://travis-ci.org/Krettis/cohoast)

## The power of a single line
Have the ability to automate your hostfile. Create automatic backups and add a hostname with just one single line in your terminal. Also comes with a fancy menu if you want to do it step by step.


### Ridin' along with the train of service
In these times with Puppet, Chef, Docker, etc, configuration of your environment shouldn't be that much of a hassle anymore. Why would the last step, adding a hostname, be done in a text file while you have your terminal right in front of you? 

Keyword is **simplicity** in your workflow and you should be _lazy_. Don't get into that textfile! 
This project comes to help for completing the last step for setting up the environment; linking it.

#### Dealing with the virtual hosts in Apache, Nginx, etc
That is a separate concern. The `hosts`-file and `virtual host configuration`-file should not go together. 


### Installation

#### Terminal

Use this command:

	curl https://raw.githubusercontent.com/Krettis/cohoast/master/.dot/install.sh | bash

#### Or manual
 Download the release or clone this repo.  the folder in the desired location. Then simple run:

    . run.sh

    
#### Environment 

Bash in 
- osx
- linux ( not tested ) 



### Configuration
In the root of the repo you can set your configuration in the YAML-file. Rename the `config.sample.yml` to `config.yml`. It is not required to configure everything, lines can be left out.



## Usage

Menu

    $ cohoast

Adding a host

    $ cohoast add [ hostname ]

Default this will added the configured default category and the default ip-address
To assign it to a different ipaddress use the `-i` or `--address` flag.
For assigning it to a another category use the `-c` or `--category` flag.    

Example of adding host with different flags:

	$ cohoast add -h sub.mydomain.com --category homemade-locals --address 192.168.22.101    
    
Block a host 

	$ cohoast block [ hostname ]
    
Deletion

	$ cohoast delete [ hostname ]

Backup

	$ cohoast backup

For a more details use `man cohoast` or `cohoast help`


    
### Tests

To check if the code is somewhat decent bash:

	make lint

For tests:

	make test



## Contributing
Having some fancy ideas what should be in this repo? [Go to my issues](http://google.com) and submit an idea. Or even better, code it yourself, create a test and do a [pull request](http://google.com).

If you see any mistakes in code or grammatics just let me know. Or better, create a pull request.


    
## Finally

### Why this project exists
I'm trying to get to know Bash some more. Doing some projects like these will get to know the more basic stuff. Also getting a better idea of what to commit in git, how the commit message should be formatted and when to move on to the next issue. So I got that going for me, which is nice. 

#### Other motive
This project is get myself working on better documentation. I've learned that no matter how good/powerful your tool is, if the documentation is poor people will just go to the alternative. Which may be suck, but it is __known__ to suck. 

#### Roadmap
Look at the documented milestones in the issue which way this is going


![The Railrodder](http://blog.nfb.ca/wp-content/uploads/2013/10/BUSTER-KEATON-insert_31.jpg "")

> _Videostill from 'The Railrodder'_

