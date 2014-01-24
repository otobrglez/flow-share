require 'spec_helper'

describe Attachment do

  it { should belong_to :attachable }
  it { should respond_to :file }
  it { should respond_to :thumb, :url, :current_path, :identifier }

end
