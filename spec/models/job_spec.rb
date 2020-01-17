require 'rails_helper'

RSpec.describe Job, type: :model do
  let(:job) { FactoryBot.build(:job) }
  
  it "can be instanciated" do
    expect(job).not_to be nil
  end

  it "can be saved" do
    expect(job.save).to be true
  end
end
