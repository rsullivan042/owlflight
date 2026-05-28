module OtelTracing
  def otel_trace(span_name, attributes = {}, tracer_name: "owlflight", flush: false)
    return yield if span_name.blank?

    tracer = OpenTelemetry.tracer_provider.tracer(tracer_name)

    result = tracer.in_span(span_name) do |span|
      attributes.each { |key, value| span.set_attribute(key.to_s, value) }

      yield if block_given?
    end

    OpenTelemetry.tracer_provider.force_flush if flush

    result
  end
end
