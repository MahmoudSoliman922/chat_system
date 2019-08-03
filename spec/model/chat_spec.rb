# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Chat do
  before(:context) do
    @application = Application.create(name: 'application1')
  end

  context 'validations' do
    describe 'application_id' do
      it 'should return true if the application_id and number are provided' do
        chat = described_class.new
        chat.number = 1
        chat.application_id = @application.id
        chat.save

        expect(chat.valid?).to eql(true)
      end

      it "should return false if the application_id isn't provided" do
        chat = described_class.new
        chat.number = 1
        chat.save

        expect(chat.valid?).to eql(false)
      end
    end

    describe 'number' do
      it 'should return true if number is provided and unique among the applications' do
        chat = described_class.new
        chat.number = 1
        chat.application_id = @application.id
        chat.save

        expect(chat.valid?).to eql(true)
      end

      it 'should return false if no number is provided ' do
        chat = described_class.new
        chat.application_id = @application.id
        chat.save

        expect(chat.valid?).to eql(false)
      end

      it "should return false if number isn't unique among the applications" do
        chat1 = described_class.new
        chat1.number = 1
        chat1.application_id = @application.id
        chat1.save

        chat2 = described_class.new
        chat2.number = 1
        chat2.application_id = @application.id
        chat2.save if chat2.valid?

        expect(chat2.valid?).to eql(false)
      end
    end
  end
end
