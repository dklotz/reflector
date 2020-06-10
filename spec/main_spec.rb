# frozen_string_literal: true

require_relative "spec_helper"

describe "reflector application" do
  let(:json_response) { JSON.parse(last_response.body) }

  it "returns valid JSON" do
    get "/"
    expect(last_response).to be_ok
    expect(last_response.content_type).to eq("application/json")
    expect(last_response.body).to be_valid_json
  end

  it "returns the client IP address" do
    get "/"
    expect(json_response["ip"]).to eq("127.0.0.1")
  end

  context "when the request is forwarded by Google's proxy" do
    let(:proxy_address) { "169.254.8.129" }
    let(:real_address) { "2a02:807:520:fd70:e94b:8430:6723:a3fa" }

    it "still returns the correct client IP address" do
      env "REMOTE_ADDR", proxy_address
      header "X-Forwarded-For", real_address

      get "/"

      expect(json_response["ip"]).to eq(real_address)
    end
  end

  it "returns the client host name" do
    get "/"
    expect(json_response["host"]).to eq("localhost")
  end

  context "when the host name could not be resolved" do
    before do
      expect(Resolv).to receive(:getname).and_raise(Resolv::ResolvError, "no name")
    end

    it "returns nil for the host name" do
      get "/"
      expect(json_response["host"]).to be_nil
    end
  end

  it "returns whether we are using IPv6" do
    get "/"
    expect(json_response["v6"]).to eq(false)
  end

  it "returns the client user agent" do
    header "User-Agent", "FooBar/1.2.3"
    get "/"
    expect(json_response["user_agent"]).to eq("FooBar/1.2.3")
  end

  it "returns request headers" do
    header "Accept-Charset", "utf-8"
    get "/"
    expect(json_response["headers"]).to include("Accept-Charset" => "utf-8")
  end
end
