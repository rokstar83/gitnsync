#!/bin/bash
############################################################################# 
# gitnsync.sh                                                               #
# Copyright (c) 2013 Tom Hartman (rokstar83@gmail.com)                      #
#                                                                           #
# This program is free software; you can redistribute it and/or             #
# modify it under the terms of the GNU General Public License               #
# as published by the Free Software Foundation; either version 2            #
# of the License, or the License, or (at your option) any later             #
# version.                                                                  #
#                                                                           #
# This program is distributed in the hope that it will be useful,           #
# but WITHOUT ANY WARRANTY; without even the implied warranty of            #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             #
# GNU General Public License for more details.                              #
#                                                                           #
# Description:                                                              #
#   gitnsync is a simple tool to report which git repositories are ahead or #
#   behind their remotes.                                                   #
#############################################################################

if [[ $# = 0 ]]; then
		projects_dir=$PWD
elif [[ $# = 1 ]]; then
		projects_dir=$1
elif [[ $# = 2 ]]; then
		opt=$1
		projects_dir=$2
else
		echo "gitnsync [option] [dir]"
		echo "  options: "
		echo "    nofetch"
fi

for project in $projects_dir/*; do
		if [[ -d "${project}/.git" ]]; then
				cd "${project}"
				if [ "$opt" != "nofetch" ]; then
						# git remote update > /dev/null 2>&1
						git remote update
				fi
				results=$(git status -sb | grep -E 'behind|ahead')
				if [ "$results" != "" ]; then
						echo "$(basename $project):"						
						echo $results
						cd ..
				fi
		fi
done
