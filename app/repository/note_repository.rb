require 'model/note'

class NoteRepository
  def initialize(dataset = DB[:notes])
    @dataset = dataset
  end

  def all
    dataset.all.map { |note| Note.new(note) }
  end

  def insert(**args)
    dataset.insert(args)
  end

  private

  attr_reader :dataset
end
