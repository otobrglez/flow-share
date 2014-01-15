shared_examples_for "nameable" do

  it { expect(subject).to respond_to :name }
  it { expect(subject.class.new(name: "Test").to_s).to eq "Test" }

end
