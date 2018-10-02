require 'rails_helper'

RSpec.describe Person, type: :model do
  it "can have a parent and children" do
    john = Person.create(name: "John")
    jim = Person.create(name: "Jim", parent: john)
    bob = Person.create(name: "Bob", parent: john)
    expect(john.children.map(&:name)).to eq ["Jim", "Bob"]
  end
end
