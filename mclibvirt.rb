require "libvirt"

module MCollective
    module Agent
        class Mclibvirt<RPC::Agent
            metadata :name        => "SimpleRPC libvirt agent",
                     :description => "libvirt wrapper for MCollective",
                     :author      => "Darren Worrall",
                     :license     => "X11",
                     :version     => "0.1",
                     :url         => "https://github.com/iwebhosting/mc-virsh",
                     :timeout     => 10
 
            @@virdomainstate = { 0 => "No state",
                             1 => "Running",
                             2 => "Blocked on resource",
                             3 => "Paused",
                             4 => "Shutting down",
                             5 => "Shut off",
                             6 => "Crashed"
            }

            # Provide some basic libvirt functionality
            action "list" do
                conn = Libvirt::open("qemu:///system")
                doms = conn.list_domains
                result = []
                doms.each do |dom|
                  domain = conn.lookup_domain_by_id(dom)
                  result << domain.name
                end
                if request[:all] 
                    result.concat(conn.list_defined_domains)
                end 
                reply.data = result
            end

            action "status" do
                validate :name, String
                conn = Libvirt::open("qemu:///system")
                begin
                    domain = conn.lookup_domain_by_name(request[:name])
                    reply.data = @@virdomainstate[domain.info.state]
                rescue Libvirt::RetrieveError => e
                    reply.fail "Unable to lookup domain #{request[:name]}", 1
                    return
                end
            end

            action "start" do 
                validate :name, String
                conn = Libvirt::open("qemu:///system")
                begin
                    domain = conn.lookup_domain_by_name(request[:name])
                    domain.create
                rescue Libvirt::RetrieveError => e
                    reply.fail "Unable to lookup domain #{request[:name]}", 1
                    return
                end
            end

            action "destroy" do 
                validate :name, String
                conn = Libvirt::open("qemu:///system")
                begin
                    domain = conn.lookup_domain_by_name(request[:name])
                    domain.destroy
                rescue Libvirt::RetrieveError => e
                    reply.fail "Unable to lookup domain #{request[:name]}", 1
                    return
                end
            end

            action "shutdown" do 
                validate :name, String
                conn = Libvirt::open("qemu:///system")
                begin
                    domain = conn.lookup_domain_by_name(request[:name])
                    domain.shutdown
                rescue Libvirt::RetrieveError => e
                    reply.fail "Unable to lookup domain #{request[:name]}", 1
                    return
                end
            end

            action "suspend" do 
                validate :name, String
                conn = Libvirt::open("qemu:///system")
                begin
                    domain = conn.lookup_domain_by_name(request[:name])
                    domain.suspend
                rescue Libvirt::RetrieveError => e
                    reply.fail "Unable to lookup domain #{request[:name]}", 1
                    return
                end
            end

            action "resume" do 
                validate :name, String
                conn = Libvirt::open("qemu:///system")
                begin
                    domain = conn.lookup_domain_by_name(request[:name])
                    domain.resume
                rescue Libvirt::RetrieveError => e
                    reply.fail "Unable to lookup domain #{request[:name]}", 1
                    return
                end
            end

        end
    end
end

