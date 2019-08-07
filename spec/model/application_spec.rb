# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Application do
  context 'validations' do
    describe 'application_token' do
      it 'should return true if the token is not repeated' do
        application1 = described_class.new
        application1.name = 'first'
        application1.save
        application2 = described_class.new
        application2.name = 'second'
        application2.save

        expect(application2.valid?).to eql(true)
      end

      it 'should generate application_token on create' do
        application1 = described_class.new
        application1.name = 'first'
        application1.save

        expect(application1.application_token.blank?).to eql(false)
      end
    end

    describe 'name' do
      it "should return 'Name can't be blank' if no name provided" do
        application = described_class.new
        application.save
        application.valid?

        expect(application.errors.full_messages[0]).to eql("Name can't be blank")
      end
    end

    describe 'chats_count' do
      it 'should have chats_count = 0 on create' do
        application1 = described_class.new
        application1.name = 'first'
        application1.save

        expect(application1.chats_count).to eql(0)
      end
    end
  end
end
