package :sqlite3, provides: :database do
  description 'SQLite'
  apt 'sqlite3 libsqlite3-dev', sudo: true

  verify do
    has_executable 'sqlite3'
  end
end
