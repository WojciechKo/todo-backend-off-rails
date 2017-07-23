require 'repository/note_repository'

RSpec.describe NoteRepository do
  let(:note_repository) { NoteRepository.new }

  it 'adds new note' do
    expect(note_repository.all).to eq([])

    note_id = note_repository.insert(text: 'Simple note example')

    expect(note_repository.all).to eq([Note.new(id: note_id, text: 'Simple note example')])
  end
end
