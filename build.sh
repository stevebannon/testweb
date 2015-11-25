#!/bin/bash
#

berks vendor vendor/cookbooks
/usr/local/packer/packer build packer.json
