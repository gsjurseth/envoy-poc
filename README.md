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

You can spin up a cluster like so (You can even do it including istio in one fell swoop):
```bash
gcloud container clusters create example-cluster --region eu-west1
```

That looks like so:
```bash
gcloud beta container clusters create CLUSTER_NAME \
    --addons=Istio --istio-config=auth=MTLS_PERMISSIVE \
    --cluster-version=CLUSTER_VERSION \
    --machine-type=n1-standard-2 \
    --num-nodes=4
```

Info from istioldie here:

https://istio.io/v1.6/docs/setup/platform-setup/gke/

Once istio is installed and configured we're going to need to create a
namespace called `myservices`. Like so:

```bash
kubectl create namespace myservices
```

## Getting the apigee adapter setup
Excellent documentation is already provided here:

https://cloud.google.com/apigee/docs/api-platform/envoy-adapter/v1.4.x/concepts

I'd recommend to follow those instructions for the latest veresion. 

**ALSO** You'll want to make sure you set `request-authentication.yaml` to use
the `myservices` namespace as opposed to default or it jwt authentcation will
fail to work.

NB: JWT
These examples are really meant to show how advanced cases with JWTs can work 
and to that end you'll need to run through these pieces as well in order
to ensure this is working and configured as well.

https://cloud.google.com/apigee/docs/api-platform/envoy-adapter/v1.4.x/operation#using-jwt-based-authentication

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
