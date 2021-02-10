class User < ApplicationRecord
  has_secure_password


  def generate_password()
    key= Passgen::generate
    info= Passgen::analyze(key)
    while info.complexity!="Strong"
      key= Passgen::generate
      info= Passgen::analyze(key)
    end 

    self.password = key
  end

end
