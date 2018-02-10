require 'repository/note_repository'

RSpec.describe NoteRepository do
  let(:note_repository) { NoteRepository.build }

  let(:message) { 'Remember to pay your taxes' }

  it 'adds new note' do
    expect(note_repository.all).to eq([])

    note = note_repository.create(text: message)

    expect(note_repository.all)
      .to contain_exactly(
        have_attributes(id: note.id, text: message)
      )
  end
end
