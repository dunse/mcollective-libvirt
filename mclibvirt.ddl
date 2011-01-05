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
