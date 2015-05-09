Cohoast 
===

Manage your hostfile in the terminal - ___v0.1.0___ _'Sand'_ [♫](https://play.spotify.com/track/0pu6LHgjcYVQZPnPgxFbzi) 

![Logo above the lonely railroad](http://i.imgur.com/S0UDcX1.jpg "Influence your hostfile in the terminal")

[![Build Status](https://travis-ci.org/Krettis/cohoast.svg?branch=develop)](https://travis-ci.org/Krettis/cohoast)


## The power of a single line
Have the ability to automate your hostfile. Create automatic backups and add a hostname with just one single line in your terminal. Also comes with a fancy menu if you want to follow a step by step way.


### Ridin' along with the train of service
In these times with Puppet, Chef and Docker, configuration of your environment shouldn't be that much of a hassle anymore. So why would the last step, adding a hostname, be done in a text file? This when you have the terminal right in front of you?
Keyword is **simplicity** in your workflow and you should be _lazy_. Don't get into that textfile! 
This project comes to help for completing the last step for setting up the environment; linking it.

#### Dealing with the virtual hosts in Apache, Nginx, etc
That is a separate concern. The `hosts`-file and `virtual host configuration`-file should not go together. Plans are for making a callback, so maybe that could help a lot of loose ends (although docker already helps you with this).

### Other motives
I'm trying to get to know Bash some more. Doing some projects like these will get to know the more basic stuff. Also getting a better idea of what to commit in git, how the commit message should be formatted and when to move on to the next issue. So I got that going for me, which is nice. 

#### And last
This project is get myself working on better documentation. I've learned that no matter how good/powerful your tool is, if the documentation is poor people will just go to the alternative. Which may be suck, but it is __known__ to suck. 


### Configuration
... _soon_

### Installation

Put the folder in the desired location. Then simple run:

    . run.sh
    
#### Environment 

Bash in 
- osx
- linux ( not tested ) 




## Usage

Menu

    $ cohoast

Adding a host

    $ cohoast add [ hostname ]
    
    
    
    

## Contributing
<!--
### Hooks


### Lint
shellcheck

### Testing

bats

-->
    
## Finally

### Plans
First concern is to add hosts, but just look at the issues page for the roadmap.


![The Railrodder](http://blog.nfb.ca/wp-content/uploads/2013/10/BUSTER-KEATON-insert_31.jpg "")

> _Videostill from 'The Railrodder'_

