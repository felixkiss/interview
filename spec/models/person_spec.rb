require 'rails_helper'

RSpec.describe Person, type: :model do
  it "can have a parent and children" do
    john = Person.create(name: "John")
    jim = Person.create(name: "Jim", parent: john)
    bob = Person.create(name: "Bob", parent: john)
    expect(john.children.map(&:name)).to eq ["Jim", "Bob"]
  end

  it "can have grandchildren" do
    sally = Person.create(name: "Sally")
    sue = Person.create(name: "Sue", parent: sally)
    kate = Person.create(name: "Kate", parent: sally)
    lisa = Person.create(name: "Lisa", parent: sue)
    robin = Person.create(name: "Robin", parent: kate)
    donna = Person.create(name: "Donna", parent: kate)
    expect(sally.grandchildren.map(&:name)).to eq ["Lisa", "Robin", "Donna"]
  end
end
