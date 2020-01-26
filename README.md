# nsq-to-x Docker hub image

## Overview

This lightweight alpine docker image provides nsq_to_x binaries for to subscribe and and send messages from nsq to http, file, tail or another nsq. and also form stream to nsq. [nsq utilities documentation](https://nsq.io/components/utilities.html). 
## Run

Example to just run nsq_to_http on entry:  
`docker run --rm mirzakhani/nsq_to_x nsq_to_http`  


## Build

For build and push image manually:  
`make build_image`
