class ReminderSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :relation, :birthday, :person_name, :send_reminder, :phone, :notes, :message
end
