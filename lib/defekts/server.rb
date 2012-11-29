module Defekts

  get "/" do
    Defekts::Pivotal.sync
    return
  end

  get "/version" do
    return Yajl::Encoder.encode("0.1")
  end

end

