#!/bin/bash 

# Using eval you can split up major and minor versions

version=4.3.15
eval major=${version/./;minor=}                  
echo major:$major,minor:$minor
