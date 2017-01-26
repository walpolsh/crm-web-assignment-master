require './test/contact_test.rb'
gem 'activerecord', '=4.2.7'
require 'active_record'
require 'mini_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'crm-web.sqlite3')


class Contact
    attr_accessor :first_name, :last_name, :email, :note
    attr_reader :id
#
  @@contacts = []
  @@id = 1

  def self.all
    @@contacts
  end

  def initialize(first_name, last_name, email, note)
    @id = @@id
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note

    @@id += 1
  end

  def self.create(first_name, last_name, email, note)
    new_contact = self.new(first_name, last_name, email, note)
    @@contacts << new_contact
    new_contact
  end

  def self.find(id)
    @@contacts.find { |contact| contact.id == id }
  end

  def update(attribute, value)
    case attribute
    when 'first_name'
       @first_name = value
    when 'last_name'
       @last_name = value
    when 'email'
       @email = value
    when 'note'
       @note = value
    end
  end

  def self.find_by(attribute, value)
      case attribute
      when 'first_name'
        @@contacts.each do |contact|
          if value == contact.first_name
            return contact
          end
        end
        "No match for #{value}"
      when 'last_name'
        @@contacts.each do |contact|
          if value == contact.last_name
            return contact
          end
        end
        "No match for #{value}"
      when 'email'
        @@contacts.each do |contact|
          if value == contact.email
            return contact
          end
        end
        "No match for #{value}"
      when 'note'
        @@contacts.each do |contact|
          if value == contact.note
            return contact
          end
        end
        "No match for #{value}"
      end
  end

  def self.delete_all
    @@contacts = []
  end

  def full_name
    return "#{first_name} #{last_name}"
  end

  def delete
    @@contacts.delete_if { |contact| contact.id == self.id }
  end
end
