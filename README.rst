An mcollective libvirt agent and client tool

The mc-virsh client tool mimics some virsh commands like list::

    $./mc-virsh list
    host1:
        onlinevm1
        onilnevm2

    host2:
        onlinevm3
    
    $./mc-virsh list --all
    host1:
        onlinevm1
        onilnevm2

    host2:
        onlinevm3
        offlinevm

And a search command to help you find a domain (useful if you use live migration)::

    $./mc-virsh search onlinevm1
    Running on host1
