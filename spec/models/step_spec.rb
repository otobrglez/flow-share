require 'spec_helper'

describe Step do

  it_behaves_like "nameable"

  it { should belong_to :flow }

end