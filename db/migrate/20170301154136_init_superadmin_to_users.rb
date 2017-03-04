class InitSuperadminToUsers < ActiveRecord::Migration[5.0]
  def up
    User.create!({username: "superadmin", password: "hpp1221802", nickname: "黄谱平"})
  end

  def down
    User.find_by_username("superadmin").destroy!
  end
end
