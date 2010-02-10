module Accessorize
  class Config
    @@meta = :current_meta
    @@accessor = :current_user
    cattr_accessor :meta
    cattr_accessor :accessor
  end
end