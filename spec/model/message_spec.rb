# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message do
  before(:context) do
    @application = Application.create(name: 'application1')
    @chat = Chat.create(number: 1, application_id: @application.id)
  end

  context 'validations' do
    describe 'chat_id' do
      it 'should return true if the chat_id, body and number are provided' do
        message = described_class.new
        message.number = 1
        message.body = 'some text'
        message.chat_id = @chat.id
        message.save

        expect(message.valid?).to eql(true)
      end

      it "should return false if the chat_id isn't provided" do
        message = described_class.new
        message.number = 1
        message.body = 'some text'
        message.save

        expect(message.valid?).to eql(false)
      end
    end

    describe 'number' do
      it 'should return true if number is provided and unique among the chats' do
        message = described_class.new
        message.number = 1
        message.chat_id = @chat.id
        message.body = 'some text'
        message.save

        expect(message.valid?).to eql(true)
      end

      it 'should return false if no number is provided ' do
        message = described_class.new
        message.chat_id = @chat.id
        message.body = 'some text'
        message.save

        expect(message.valid?).to eql(false)
      end

      it "should return false if number isn't unique among the chats" do
        message1 = described_class.new
        message1.number = 1
        message1.body = 'some text'
        message1.chat_id = @chat.id
        message1.save

        message2 = described_class.new
        message2.number = 1
        message2.body = 'some text'
        message2.chat_id = @chat.id
        message2.save if message2.valid?

        expect(message2.valid?).to eql(false)
      end
    end

    describe 'body' do
      it 'should return true if the body is provided' do
        message = described_class.new
        message.number = 1
        message.body = 'some text'
        message.chat_id = @chat.id
        message.save

        expect(message.valid?).to eql(true)
      end

      it "should return false if the body isn't provided" do
        message = described_class.new
        message.number = 1
        message.chat_id = @chat.id
        message.save

        expect(message.valid?).to eql(false)
      end
    end
  end
end
