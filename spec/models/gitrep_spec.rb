# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Gitrep, type: :model do
  before(:each) do
    @gituser = Gituser.create(log: 'any', name: 'any')
  end

  subject do
    @gituser.gitreps.new(name: 'any')
  end
  it 'Valid with name' do
    expect(subject).to be_valid
  end

  it 'Not valid with no name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Recoed without user' do
    Gitrep.create(name: 'bla-bla-bla')
    expect(Gitrep.count).to eq 0
  end

  it 'Multiple record' do
    (1..10).each do |i|
      @gituser.gitreps.create(name: "any#{i}")
    end
    expect(Gitrep.count).to eq 10
  end

  it 'Getting by using user_id for finding' do
    gituser1 = Gituser.create(log: 'any', name: 'any')
    gituser2 = Gituser.create(log: 'any1', name: 'any1')
    users = [gituser1, gituser2]
    (1..5).each do |i|
      users.each do |user|
        user.gitreps.create(name: "bla-bla-bla#{i}")
      end
    end
    expect(Gitrep.where(gituser_id: 2).count).to eq 5
  end

  it 'Getting names of repos' do
    (1..10).each do |i|
      @gituser.gitreps.create(name: "repo_name#{i}")
    end
    expect(Gitrep.find(1).name).to eq 'repo_name1'
  end

  it 'Updating name of repo' do
    repo = @gituser.gitreps.create(name: 'hello')
    repo.name = 'hi'
    repo.save
    expect(repo.name).to eq 'hi'
  end

  it 'Destroying all records' do
    (1..10).each do |_i|
      @gituser.gitreps.create(name: 'name')
    end
    Gitrep.delete_all
    expect(Gitrep.count).to eq 0
  end
end
