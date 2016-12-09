class User < ApplicationRecord
    has_many :novel
    # has_many :updates , :through=> :novel
end
