class TriggeredAction
  include DataMapper::Resource

  property :from_user,  String,  required: true, key: true
  property :regex,      String,  required: true, key: true
  property :action,     String,  required: true
  property :created_by, String,  required: true
  property :created_at, DateTime
  property :updated_at, DateTime
end

class Command
  include DataMapper::Resource

  property :keyword,    String,  required: true, key: true
  property :command,    String,  required: true
  property :created_by, String,  required: true
  property :created_at, DateTime
  property :updated_at, DateTime
end

=begin
class Alias
  include DataMapper::Resource
  property :created_by, String, :required:  true
  property :created_at, DateTime
  property :updated_at, DateTime
end
=end

DataMapper.finalize.auto_upgrade!

Command.first_or_create(keyword: 'remember', command: 'fuckit', created_by: 'internal')
