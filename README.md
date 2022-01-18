![](https://img.shields.io/badge/Stability-Experimental-red.svg)

This repository is [Experimental](https://github.com/packethost/standards/blob/master/experimental-statement.md) meaning that it's based on untested ideas or techniques and not yet established or finalized or involves a radically new and innovative style! This means that support is best effort (at best!) and we strongly encourage you to NOT use this in production.

# BGP-Anycast-Workshop

One of the best ways to run a highly redundant cluster of servers is by using BGP, Border Gateway Protocol, and one of the best tools for deploying a cluster of servers is via Terraform. This workshop shows how Terraform and BGP, along with IPv6, can be used to easily deploy, grow, and shrink a cluster of bare metal hosts.

This repo contains all the instructions to setup a lab supporting multiple concurrent students each with his/her own environment of deployed bare metal hosts. This lab is configured to utilize bare metal infrastructure provided by [Equinix Metal](http://metal.equinix.com).

This repo contains everything you need to setup a BGP Anycast Workshop and the workshop instructions for students to follow. Students will learn how to automate the deployment of a multi host, BGP IPv6 Anycast enabled network using tools such as Terraform and BIRD, a software based router. Students will need a SSH client (such as PuTTY) to use this lab. Some experience with the Linux command line is useful.

# Student Access

If you're a student attending an in-person workshop, please proceed to [Lab01.md](Lab01.md).

# Lab Setup

If you're interested in setting up a full lab for use by students, please read [Building Workshop](BuildingWorkshop.md).
