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

```
bgp03@stl:~/WorkspaceTemplate$ terraform output
Anycast IPv6 Address = 2604:1380:2:2302::3
Anycast IPv6 Network = 2604:1380:2:2302::/64
Server IPs v4 = [
    147.75.194.9,
    147.75.195.57
]
Server IPs v6 = [
    2604:1380:2:2300::7,
    2604:1380:2:2300::d
]
Test Command = curl http://[2604:1380:2:2302::3]
```


And let's do a quick network connectivity check to each host.

```
ping -c 5 <Server #1 IP v4>
ping -c 5 <Server #2 IP v4>
```

You should see something like:
```
bgp03@stl:~/WorkspaceTemplate$ ping -c 5 147.75.194.9
PING 147.75.194.9 (147.75.194.9) 56(84) bytes of data.
64 bytes from 147.75.194.9: icmp_seq=1 ttl=60 time=0.206 ms
64 bytes from 147.75.194.9: icmp_seq=2 ttl=60 time=0.121 ms
64 bytes from 147.75.194.9: icmp_seq=3 ttl=60 time=0.183 ms
64 bytes from 147.75.194.9: icmp_seq=4 ttl=60 time=0.119 ms
64 bytes from 147.75.194.9: icmp_seq=5 ttl=60 time=0.176 ms

--- 147.75.194.9 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4093ms
rtt min/avg/max/mdev = 0.119/0.161/0.206/0.034 ms
bgp03@stl:~/WorkspaceTemplate$ ping -c 5 147.75.195.57
PING 147.75.195.57 (147.75.195.57) 56(84) bytes of data.
64 bytes from 147.75.195.57: icmp_seq=1 ttl=60 time=0.169 ms
64 bytes from 147.75.195.57: icmp_seq=2 ttl=60 time=0.111 ms
64 bytes from 147.75.195.57: icmp_seq=3 ttl=60 time=0.169 ms
64 bytes from 147.75.195.57: icmp_seq=4 ttl=60 time=0.156 ms
64 bytes from 147.75.195.57: icmp_seq=5 ttl=60 time=0.165 ms

--- 147.75.195.57 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4073ms
rtt min/avg/max/mdev = 0.111/0.154/0.169/0.022 ms
```

All the hosts should reply back from the ping requests. If, for some reason, your hosts are not responding, please go back and pick a different lab assignment and reverify.

## Next Steps

Once you've validated your environment, proceed to [Lab 2](Lab02.md)
