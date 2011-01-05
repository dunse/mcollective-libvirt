metadata :name        => "SimpleRPC libvirt agent",
         :description => "libvirt wrapper for MCollective",
         :author      => "Darren Worrall",
         :license     => "?",
         :version     => "0.1",
         :url         => "http://none",
         :timeout     => 10
 
action "list", :description => "List running domains" do
    display :always
    input :all,
          :prompt      => "List all?",
          :description => "List all domains, not just running ones",
          :type        => :boolean,
          :optional    => true
 
    output :data,
           :description => "Matching domains",
           :display_as  => "Domains"
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
