# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Gituser, type: :model do
  subject do
    described_class.new(log: 'anything', name: 'badboy')
  end
  it 'is valid with attrs' do
    expect(subject).to be_valid
  end
  it 'is not valid without log' do
    subject.log = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid without name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Writing multiple records' do
    (1..10).each do |_i|
      Gituser.create(log: 'any', name: 'badboy')
    end
    expect(Gituser.count).to eq 10
  end

  it 'Taking subject by only log' do
    (1..10).each do |i|
      Gituser.create(log: "any#{i}", name: 'any')
    end
    expect(Gituser.find_by_log('any1').log).to eq 'any1'
  end

  it 'Taking subject by log and checking up its name' do
    (1..10).each do |i|
      Gituser.create(log: "any#{i}", name: "any#{i}")
    end
    expect(Gituser.find_by_log('any1').name).to eq 'any1'
  end

  it 'Taking subject by id and changing it' do
    Gituser.create(log: 'any', name: 'any')
    user = Gituser.find(1)
    user.update(name: 'Vasya')
    expect(user.name).to eq 'Vasya'
  end

  it 'Taking subject by id and changing it' do
    Gituser.create(log: 'any', name: 'any')
    name_ch = 'Vasya'
    user = Gituser.find(1)
    user.update(name: nil)
    expect(user).to_not be_valid
  end
end
