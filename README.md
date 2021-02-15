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

Once istio is installed and configured we're going to need to create a
namespace called `myservices`. Like so:

```bash
kubectl create namespace myservices
```

## The docker images
I've provided a makefile here which should do the following automatically:
* build the images
* tag the images
* push the images 

To do all this you'll need to edit the Makefile and set the gcrpath and the
version if its changed. This requires that you have a docker setup to work
properly

## Deploy the images
At this point you should be able to simply:

```bash
kubectl apply -f kubernetes-manifests
```

## The gateway
The provided gateway file is just an example and assumes certificates via
letsencrypt.  You may do something simpler, of course, but be aware that
whatever that ingress gateway is (ip, domain name, or otherwise) will have
an impact on how you specify those targets in the API Product setup later.
