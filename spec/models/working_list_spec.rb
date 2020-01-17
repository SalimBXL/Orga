require 'rails_helper'

RSpec.describe WorkingList, type: :model do
  let(:working_list) { FactoryBot.build(:working_list) }
  
  it "can be instanciated" do
    expect(working_list).not_to be nil
  end

  it "can be saved" do
    expect(working_list.save).to be true
  end
end
