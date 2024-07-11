# frozen_string_literal: true

def something
  yield('Preston') if block_given?
end

# something { |name| puts name }
something
