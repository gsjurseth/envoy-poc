# envoy-poc
Basic contents of this repo:
* src for docker images
* kubernets specs for the pods
* istio ingress spec (gateway and ingress)
* This readme which provides some context for it all

Basically we gotta get this all setup so that we can run this simple POC

## A k8s instance with istio enabled (at least version 1.6)
Presumably you'll be running this on GKE, but you'll need a K8S instance 
somewhere running at least version 1.6 as everything in here relies on it.

## The docker images
I've provided a makefile here which should do the following automatically:
* build the images
* tag the images
* push the images 

To do all this you'll need to edit the Makefile and set the gcrpath and the
version if its changed. This requires that you have a docker setup to work
properly
