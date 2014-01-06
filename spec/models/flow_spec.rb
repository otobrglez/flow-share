require 'spec_helper'

describe Flow do

  it_behaves_like "nameable"

  it { Flow.new(name: "Simple flow").to_s.should eq "Simple flow"}


end
