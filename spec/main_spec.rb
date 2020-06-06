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
    get "/"
    expect(json_response).to have_key("user_agent") # rack-test doesn't send a user agent
  end
end
