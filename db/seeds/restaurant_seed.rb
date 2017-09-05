10.times do |i|
  user = User.create(username: "user#{i}", password: "user#{i}123")
  user.restaurants.create(name: "Restaurant #{i}", user_type: 'owner')
end
# user_values = []
# user_ids = []
# 10.times do |i|
#   user_ids << "user#{i}"
#   user_values << "(user#{i},user#{i}123,'owner')"
# end
# user_values = user_values.join(',')
# ActiveRecord::Base.connection.execute("INSERT INTO users (username, passsword,user_type) VALUES #{user_values}")
#
# values = user_ids.map { |u| "(#{mass_email.id},#{u.id})" }.join(",")

10.times do |t|
  User.create(username: "user#{t+10}", password: "user#{t+10}123", user_type: 'user')
end