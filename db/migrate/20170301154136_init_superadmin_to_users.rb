class InitSuperadminToUsers < ActiveRecord::Migration[5.0]
  def up
    return if Rails.env == 'test'
    User.create!({
      username: "superadmin",
      password: Digest::MD5.hexdigest("hpp1221802".encode('utf-8')).upcase,
      nickname: "黄谱平"
    })
  end

  def down
    return if Rails.env == 'test'
    User.find_by_username("superadmin").destroy!
  end
end
