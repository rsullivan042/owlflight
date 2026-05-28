require "rails_helper"

RSpec.describe OtelTracing do
  include OtelTracing

  it "yields and returns the block result" do
    result = otel_trace("test.span") { 42 }
    expect(result).to eq(42)
  end

  it "returns the block result when span_name is blank" do
    result = otel_trace("") { "fallback" }
    expect(result).to eq("fallback")
  end

  it "sets attributes on the span without error" do
    expect {
      otel_trace("test.span", { "foo" => "bar" }) { nil }
    }.not_to raise_error
  end
end
