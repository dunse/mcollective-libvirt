require "libvirt"

module MCollective
    module Agent
        class Mclibvirt<RPC::Agent
            metadata :name        => "SimpleRPC libvirt agent",
                     :description => "libvirt wrapper for MCollective",
                     :author      => "Darren Worrall",
                     :license     => "?",
                     :version     => "0.1",
                     :url         => "http://will.push.to.github.if.it.works",
                     :timeout     => 10

            # Provide some basic libvirt functionality
            action "list" do
#                validate :all, Boolean
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
                reply.data = result.join(" | ")
            end

        end
    end
end

