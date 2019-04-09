# Lab 01 - Lab Access

## Prerequisites

* Laptop with SSH client (PuTTy). The Windows client can be downloaded [here](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html).

## Lab Assignment & Credentials

On the whiteboard/projector, there will be a link to an etherpad listing all the available lab environments along with the default password. Follow the link and write your name alongside a lab number (i.e. bgp03 - John Doe).

Take note of the name of the "lab master" server on the whiteboard/projector. This will be the jump server from where you will access 

If you ever need a new lab environment, return to this page and simply assign yourself a new one. Mark any old/broken lab environments as "broken/recycle" and it will be rebuilt.

## Lab Master Access

With your assigned lab (i.e. bgp03), log into the lab master server using the your assigned lab and the password. You'll need to use a SSH client (i.e. PuTTy). 

```
ssh <your_lab>@<lab_master>
```

## Verify Deployed Web Instances

We've already taken the liberty of deploying a number of servers into your environment and setting them up with IPv6 and Anycast. This way you can see the end result. Don't worry, you'll get a chance to deploy it all yourself shortly.

Let's verify that all your hosts are deployed OK. You should have two physical hosts deployed, each with IPv4 and IPv6 addresses. 

```
cd WorkspaceTemplate
terraform output
```

And let's do a quick network connectivity check to each host.

```
ping -c 5 <web_host_1_ipv4>
ping -c 5 <web_host_2_ipv4>
```

All the hosts should reply back from the ping requests. If, for some reason, your hosts are not responding, please go back and pick a different lab assignment and reverify.

## Next Steps

Once you've validated your environment, proceed to [Lab 2](Lab02.md)
