module Defekts

  get "/" do
    Pivotal.sync
    #p = Project.create( :name => "frameworks", :origin_id => "72352" )
    #po = Project.find_by_origin_id("72351")
    #puts po.id
    #puts po.name
    return
  end

  get "/version" do
    return Yajl::Encoder.encode("0.1")
  end

end

