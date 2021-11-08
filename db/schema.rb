# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_211_106_170_941) do
  create_table 'answers', force: :cascade do |t|
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'flashcard_id'
    t.boolean 'result'
    t.index ['flashcard_id'], name: 'index_answers_on_flashcard_id'
  end

  create_table 'flashcard_sessions', force: :cascade do |t|
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'student_id'
    t.index ['student_id'], name: 'index_flashcard_sessions_on_student_id'
  end

  create_table 'flashcard_sessions_flashcards', id: false, force: :cascade do |t|
    t.integer 'flashcard_id'
    t.integer 'flashcard_session_id'
    t.index ['flashcard_id'], name: 'index_flashcard_sessions_flashcards_on_flashcard_id'
    t.index ['flashcard_session_id'], name: 'index_flashcard_sessions_flashcards_on_flashcard_session_id'
  end

  create_table 'flashcards', force: :cascade do |t|
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.text 'question'
    t.text 'answer'
  end

  create_table 'groups', force: :cascade do |t|
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'teacher_id'
    t.string 'name'
    t.index ['teacher_id'], name: 'index_groups_on_teacher_id'
  end

  create_table 'parents', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'name'
    t.string 'surname'
    t.string 'phone_number'
    t.index ['email'], name: 'index_parents_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_parents_on_reset_password_token', unique: true
  end

  create_table 'parents_students', id: false, force: :cascade do |t|
    t.integer 'student_id'
    t.integer 'parent_id'
    t.index ['parent_id'], name: 'index_parents_students_on_parent_id'
    t.index ['student_id'], name: 'index_parents_students_on_student_id'
  end

  create_table 'students', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'group_id'
    t.string 'name'
    t.string 'surname'
    t.date 'date_of_birth'
    t.index ['email'], name: 'index_students_on_email', unique: true
    t.index ['group_id'], name: 'index_students_on_group_id'
    t.index ['reset_password_token'], name: 'index_students_on_reset_password_token', unique: true
  end

  create_table 'teachers', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'name'
    t.string 'surname'
    t.string 'phone_number'
    t.index ['email'], name: 'index_teachers_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_teachers_on_reset_password_token', unique: true
  end
end
