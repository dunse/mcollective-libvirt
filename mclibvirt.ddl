metadata :name        => "SimpleRPC libvirt agent",
         :description => "libvirt wrapper for MCollective",
         :author      => "Darren Worrall",
         :license     => "?",
         :version     => "0.1",
         :url         => "http://none",
         :timeout     => 10
 
action "list", :description => "List running domains" do
    input :all,
          :prompt      => "List all?",
          :description => "List all domains, not just running ones",
          :type        => :boolean,
          :optional    => true
 
    output :data,
           :description => "Matching domains",
           :display_as  => "Domains"
end
 
action "search", :description => "Find a domain" do
    input :name,
          :prompt      => "Domain name",
          :description => "The domain to find",
          :type        => :string,
 
    output :data,
           :description => "Matching hosts",
           :display_as  => "Matching hosts"
end

action "status", :description => "Report the status of a given domain" do
    display :ok
    input :name,
          :prompt      => "Domain name",
          :description => "The name of the domain you're interested in.",
          :type        => :string,
          :validation  => '^[a-zA-Z\-_\d]+$',
          :maxlength   => 30,
          :optional    => false
 
    output :data,
           :description => "Status of the domain",
           :display_as  => "Status:"
end

["start", "shutdown", "destroy", "suspend", "resume"].each do |act|
    action act, :description => "#{act.capitalize} a domain" do
        input :name,
              :prompt      => "Domain Name",
              :description => "The domain to #{act}",
              :type        => :string,
              :validation  => '^[a-zA-Z\-_\d]+$',
              :optional    => false,
              :maxlength   => 30

    end
end
