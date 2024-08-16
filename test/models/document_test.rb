require "test_helper"

class DocumentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: documents
#
#  id         :bigint           not null, primary key
#  is_public  :boolean          default(TRUE)
#  kind       :string
#  state      :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :string           not null
#
