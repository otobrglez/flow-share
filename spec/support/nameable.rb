shared_examples_for "nameable" do

  it { should respond_to :name }
  it { should respond_to :to_s }

  it { subject.class.new(name: "Test").to_s.should eq "Test" }

end
